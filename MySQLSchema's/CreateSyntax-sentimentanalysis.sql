-- Create syntax for 'sentimentanalysis'

CREATE TABLE `sentimentanalysis` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tweets` text,
  `emotion` text,
  `polarity` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3400 DEFAULT CHARSET=utf8;
