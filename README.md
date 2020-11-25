## reverseproxy.arx.pw

### docker reverse proxy for easier development

( Made to get around finicky issues with general CORS on browsers during development, easier emulation of production )


1. Give yourself permissions to run the build and run scripts
```
chmod +x build.sh run.sh
```

2. Build
```./build.sh```

3. Run ( runs on port 1010 by default - mapping to port 8000 )

Change this in your `nginx.conf` if you don't want these ports.

```./run.sh```

4. DONE! This is now running in detached mode. Use `docker ps` to see if it's running!
