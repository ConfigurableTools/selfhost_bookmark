# SelfHost_Bookmark

An opensource selfhost bookmark program. The services currently can record the bookmarks collected and count the number of visits to the bookmarks. More features ( sorting , filtering , search , WebDAV, url speed test ) is under development :)

![image](https://github.com/ConfigurableTools/selfhost_bookmark/assets/155286068/c852ce3f-8483-4aca-8d8b-ab648dadeffb)

## Download

See [Release](https://github.com/ConfigurableTools/selfhost_bookmark/releases)

## Usage

Requirement: Python >= 3.6

```bash
unzip termux-web-bookmark_v1.2.zip
cd bookmark
python main.py
```

If you're using termux, it's better to make sure the program runs all the time by doing the following:

```bash
# install tool
pkg install termux-services -y

# EXIT the termux, and then RESTART，then
cd /data/data/com.termux/files/usr/var/service
mkdir bookmark
cd bookmark

# use vim create a file
vim run
```

Input the following
```bash
#!/data/data/com.termux/files/usr/bin/bash
cd ~/bookmark/
python main.py
```

Add script permession
```bash
chmod +x run
sv enable bookmark
sv status bookmark
```

## Extension

[FileFox](https://addons.mozilla.org/zh-CN/firefox/addon/selfhostbookmark/) now available！

Get the title and URL address of the current tab and send the data to the self-deployed Web service (Windows, Termux, Linux) through the interface to realize the data connection.

![image](https://github.com/ConfigurableTools/selfhost_bookmark/assets/155286068/3786f6df-96ea-4d72-a8fe-4f9db7abaf51)

Extension Option

![image](https://github.com/ConfigurableTools/selfhost_bookmark/assets/155286068/ae8fd432-291a-4d7d-baa0-112211d27702)
