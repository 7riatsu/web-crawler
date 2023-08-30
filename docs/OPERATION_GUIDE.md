# Web Crawler Operation Guide

## 1. Build Docker Container
```bash
docker build -t web_crawler .
```

## 2. Enter Docker Container

To initiate and enter the Docker container, use:

```bash
docker run -it --entrypoint "/bin/bash" web_crawler
```

## 3. Fetch Metadata from Websites
For a single site:

```bash
ruby /app/bin/run.rb https://example.com
```

For multiple sites:

```bash
ruby /app/bin/run.rb https://example.com https://www.google.com
```

## 4. Check Saved Pages
List saved pages:

```bash
# Example: The HTML and asset files of a website are displayed as follows
ls /app/saved_pages/
example.com.html  googlelogo_white_background_color_272x92dp.png  www.google.com.html
```

To view the content of a saved page:
```bash
cat /app/saved_pages/example.com.html
```
Replace example.com.html with the desired filename, like www.google.com.html.
