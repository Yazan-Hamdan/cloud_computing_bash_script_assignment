## Script_1: Add the script to Linux path

Move the script to a directory in your PATH, for example **`/usr/local/bin`**. You can do this by running the following command:

`sudo mv LunixStatus /usr/local/bin`

Make the script executable by running the following command:

`sudo chmod 700 /usr/local/bin/LunixStatus`

Verify that the script is now in your PATH by running the following command:

`echo $PATH`

This should display a list of directories separated by colons. Verify that **`/usr/local/bin`** is one of the directories listed.

You can now run the script from anywhere in the terminal by simply typing **`LunixStatus`**. If you want to pass any arguments to the script, you can do so by typing them after the script name, for example:

`LunixStatus p r a`




## Script_2: add the script to cronjob

To schedule the script to run daily at midnight, add a cronjob by running the following command:

 `crontab -e`

This will open the cronjob file in the default text editor. Add the following line to the end of the file to run the script at midnight:

`0 0 * * * /path/to/cronjob.sh`

Replace **`/path/to/cronjob.sh`** with the actual path to the script file. Save the file and exit the text editor. The script will now run daily at midnight and update the website.