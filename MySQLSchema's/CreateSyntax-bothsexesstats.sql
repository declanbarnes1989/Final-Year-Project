-- Create syntax for 'bothsexesstats'

CREATE TABLE `bothsexesstats` (
  `row_names` text,
  `Sex` text,
  `County` text,
  `Amount` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
