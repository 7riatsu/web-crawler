# Web crawler
## Requirements
* docker

## Building the Docker image
```bash
docker build -t web_crawler .
```

## Usage
```bash
docker run web_crawler [URL1] [URL2] ...
```

For example:
```bash
docker run web_crawler https://example.com https://www.google.com
```

## Running tests
```bash
docker run --entrypoint "ruby" web_crawler /app/test/fetcher_test.rb
```
