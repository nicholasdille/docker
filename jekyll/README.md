# Introduction

Base container for building and testing [Jekyll](https://jekyllrb.com/) based sites

# Usage

There several ways to use this container.

## Integrate your site

Create a derived image and add your site source to the image:

```Dockerfile
FROM nicholasdille/jekyll

ADD _drafts   /site/_drafts
ADD _includes /site/_includes
ADD _layouts  /site/_layouts
ADD _posts    /site/_posts
ADD media     /site/media
ADD _config.yml 404.html index.html sitemap.xml /site/
```

After building your image, you can build and test your site:

```
docker run -dp 80:80 jekyll-site
```

## Serve your site from a git repository

Alternatively, you can provide an environment variable called GIT_URL to point to a git repository. The entrypoint will pull the site from the specified repository and build it:

```
docker run -dp 80:80 -e GIT_URL=https://github.com/nicholasdille/nicholasdille.github.io nicholasdille/jekyll
```
