install.packages("tm")
download.file("http://cran.cnr.berkeley.edu/src/contrib/Archive/Rstem/Rstem_0.4-1.tar.gz", "Rstem_0.4-1.tar.gz") 
install.packages("Rstem_0.4-1.tar.gz", repos=NULL, type="source")

# authorisation
if (!require('pacman')) install.packages('pacman')
pacman::p_load(twitteR, ROAuth, RCurl)

api_key = 'buQJdPLi6pNHANqo95PSqzT4Q'
api_secret = 'zRsvln2oeLgXJsWyd3jfnFobYI1eJRvFPvl0Q4rBnmlhrL7fba'
access_token = '786160713173651456-mrtbqzxj6RB07KY8tIKOfxYDFTrCg35'
access_token_secret = 'e26qg9Xm9hBss4ThCpDlbnqWXZMQLCB87kFk42oEVsQku'

# Set SSL certs globally
options(RCurlOptions = list(cainfo = system.file('CurlSSL', 'cacert.pem', package = 'RCurl')))

# set up the URLs
reqURL = 'https://api.twitter.com/oauth/request_token'
accessURL = 'https://api.twitter.com/oauth/access_token'
authURL = 'https://api.twitter.com/oauth/authorize'

twitCred = OAuthFactory$new(consumerKey = api_key, consumerSecret = api_secret, requestURL = reqURL, accessURL = accessURL, authURL = authURL)

twitCred$handshake(cainfo = system.file('CurlSSL', 'cacert.pem', package = 'RCurl'))

if (!require('pacman')) install.packages('pacman&')
pacman::p_load(devtools, installr)
install.Rtools()
install_url('http://cran.r-project.org/src/contrib/Archive/Rstem/Rstem_0.4-1.tar.gz')
install_url('http://cran.r-project.org/src/contrib/Archive/sentiment/sentiment_0.2.tar.gz')


# START HERE
if (!require('pacman')) install.packages('pacman')
pacman::p_load(twitteR, sentiment, plyr, ggplot2, wordcloud, RColorBrewer, httpuv, RCurl, base64enc)

options(RCurlOptions = list(cainfo = system.file('CurlSSL', 'cacert.pem', package = 'RCurl')))

api_key = 'buQJdPLi6pNHANqo95PSqzT4Q'
api_secret = 'zRsvln2oeLgXJsWyd3jfnFobYI1eJRvFPvl0Q4rBnmlhrL7fba'
access_token = '786160713173651456-mrtbqzxj6RB07KY8tIKOfxYDFTrCg35'
access_token_secret = 'e26qg9Xm9hBss4ThCpDlbnqWXZMQLCB87kFk42oEVsQku'

setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

# harvest some tweets
disability_tweets = searchTwitter('disability', n=10000, lang='en')

# get the text
disability_txt = sapply(disability_tweets, function(x) x$getText())

# remove retweet entities
disability_txt = gsub('(RT|via)((?:\\b\\W*@\\w+)+)', '', disability_txt)
# remove at people
disability_txt = gsub('@\\w+', '', disability_txt)
# remove punctuation
disability_txt = gsub('[[:punct:]]', '', disability_txt)
# remove numbers
disability_txt = gsub('[[:digit:]]', '', disability_txt)
# remove html links
disability_txt = gsub('http\\w+', '', disability_txt)
# remove unnecessary spaces
disability_txt = gsub('[ \t]{2,}', '', disability_txt)
disability_txt = gsub('^\\s+|\\s+$', '', disability_txt)

# define 'tolower error handling' function
try.error = function(x)
{
  # create missing value
  y = NA
  # tryCatch error
  try_error = tryCatch(tolower(x), error=function(e) e)
  # if not an error
  if (!inherits(try_error, 'error'))
    y = tolower(x)
  # result
  return(y)
}
# lower case using try.error with sapply
disability_txt = sapply(disability_txt, try.error)

# remove NAs in disability_txt
disability_txt = disability_txt[!is.na(disability_txt)]
names(disability_txt) = NULL

disability_txt <- disability_txt[ ! duplicated( disability_txt ) ]
# Perform Sentiment Analysis
# classify emotion
class_emo = classify_emotion(disability_txt, algorithm='bayes', prior=1.0)
# get emotion best fit
emotion = class_emo[,7]
# substitute NA's by 'unknown'
emotion[is.na(emotion)] = 'unknown'

# classify polarity
class_pol = classify_polarity(disability_txt, algorithm='bayes')
# get polarity best fit
polarity = class_pol[,4]
# Create data frame with the results and obtain some general statistics
# data frame with results
sent_df = data.frame(text=disability_txt, emotion=emotion,
                     polarity=polarity, stringsAsFactors=FALSE)

# sort data frame
sent_df = within(sent_df,
emotion <- factor(emotion, levels=names(sort(table(emotion), decreasing=TRUE))))
write.csv(sent_df, file = "DisabilityTweets.csv")

# Let’s do some plots of the obtained results
# plot distribution of emotions
ggplot(sent_df, aes(x=emotion)) +
  geom_bar(aes(y=..count.., fill=emotion)) +
  scale_fill_brewer(palette='Dark2') +
  labs(x='emotion categories', y='number of tweets') +
  ggtitle('Sentiment Analysis of Tweets about disabilities\n(classification by emotion)') +
  theme(plot.title = element_text(size=12, face='bold'))


# plot distribution of polarity
ggplot(sent_df, aes(x=polarity)) +
  geom_bar(aes(y=..count.., fill=polarity)) +
  scale_fill_brewer(palette='RdGy') +
  labs(x='polarity categories', y='number of tweets') +
  ggtitle('Sentiment Analysis of Tweets about Disabilities\n(classification by polarity)') +
  theme(plot.title = element_text(size=12, face='bold'))

write.csv(sent_df, file = "tweets.csv")
# Separate the text by emotions and visualize the words with a comparison cloud
# separating text by emotion
emos = levels(factor(sent_df$emotion))
nemo = length(emos)
emo.docs = rep('', nemo)
for (i in 1:nemo)
{
  tmp = disability_txt[emotion == emos[i]]
  emo.docs[i] = paste(tmp, collapse='')
}

# remove stopwords
emo.docs = removeWords(emo.docs, stopwords('english'))
# create corpus
corpus = Corpus(VectorSource(emo.docs))
tdm = TermDocumentMatrix(corpus)

# comparison word cloud
col=brewer.pal(6,"Dark2")
wordcloud(tdm, min.freq=25, scale=c(5,2),rot.per = 0.25,
          random.color=T, max.word=45, random.order=F,colors=col)
