# Web Crawler Operation Guide

## 1. Enter Docker Container

To initiate and enter the Docker container, use:

```bash
docker run -it --entrypoint "/bin/bash" web_crawler
```

## 2. Fetch Metadata from Websites
For a single site:

```bash
ruby /app/bin/run.rb https://example.com
```

For multiple sites:

```bash
ruby /app/bin/run.rb https://example.com https://www.google.com
```

## 3. Check Saved Pages
List saved pages:

```bash
ls /app/saved_pages/
```

To view the content of a saved page:
```bash
cat /app/saved_pages/example.com.html
```
Replace example.com.html with the desired filename, like www.google.com.html.
