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
docker run --entrypoint "sh" web_crawler -c "ruby -Ilib:test -e 'ARGV.each { |f| require f }' /app/test/*_test.rb"
```
