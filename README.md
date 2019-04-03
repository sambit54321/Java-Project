Download Example Files
Download the following file in this repo to a local directory:

apache_logs - sample data (in apache combined log format)
Unfortunately, Github does not provide a convenient one-click option to download entire contents of a subfolder in a repo. Use sample code provided below to download the required files to a local directory:

wget https://raw.githubusercontent.com/elastic/examples/master/Common%20Data%20Formats/apache_logs/apache_logs
Run Example
1. Ingest data into Elasticsearch using Filebeat Module
From the Filebeat installation directory setup the apache2 module and ingest the sample provided. Modify the following command to include the location to the above sample data file.
cd <path_to_filebeat_root_dir>
