# hugo-contentful-blog

Blog sample with Hugo and Contentful by [ModiiMedia/contentful-hugo](https://github.com/ModiiMedia/contentful-hugo).  
This sample site has been generated by Github Actions with Contentful Webhook, and published by Github Pages.

[Sample Site(Japanese)](https://higebobo.github.io/hugo-contentful-blog/)

## System configuration and work flow

![diagram](./images/diagram/work-flow.svg)

## Set up

* requirements
    * Hugo
    * Node.js

### By clone

Clone this repository including submodules

```shell
git clone --recursive https://github.com/higebobo/hugo-contentful-blog
```

Move to the site directory

```shell
cd hugo-contentful-blog
```

Install the package for Node.js(postcss, contentful-hugo)

```shell
npm install
```

### From scratch

Create a new site

```shell
hugo new site hugo-contentful-blog
```

Move to the site directory

```shell
cd hugo-contentful-blog
```

Create a git repository

```shell
git init
echo '*~' >> .gitignore
echo '*.bak' >> .gitignore
echo '*.orig' >> .gitignore
echo '.env' >> .gitignore
echo 'public' >> .gitignore
echo 'resources' >> .gitignore
```

Copy config file and others from theme directory

```shell
cp -pr themes/blonde/exampleSite/{config.toml,content,package.json} .
```

Install postcss

```shell
npm install
echo 'node_modules' >> .gitignore
```

Install contentful-hugo

```shell
npm install contentful-hugo
contentful-hugo --init
```

Add scripts in package.json

```json
{
    "name": "Hugo-Contenful",
    "scripts": {
        "dev": "contentful-hugo --preview && hugo server",
        "build": "contentful-hugo && hugo --minify"
    },
```

### Contentful models

Create contentful models as you like.
In my case, these (**id is important rather than name**)

#### Blog post

* name: HugoContentfulPost
* id: hugoContentfulPost

![models](./images/screenshots/01.png)

#### Blog category

* name: HugoContentfulCategory
* id: hugoContentfulCategory

![models](./images/screenshots/02.png)

#### Blog tag

* name: HugoContentfulTag
* id: hugoContentfulTag

![models](./images/screenshots/02.png)

### Github Actions and Github Pages

Set `.github/workflows/<youractions>.yaml` and environment variables for Contentful in `Settings`>`Secrets`

My settings is [here](./.github/workflows/gh-pages.yaml)

## Customize

You need customize setting files.

* .env
    * copy from the [.env.sample](./.env.sample) and edit
* [config.toml](./config.toml)
* [contentful-hugo.config.js](./contentful-hugo.config.js)

Also, set the secrets to use Github Actioins

* CONTENTFUL_SPACE: your contentful space id
* CONTENTFUL_TOKEN: your contentful token
* BASE_URL: base url of hugo to deploy (for example "https://foo.github.io/")

## Run

Run server

```shell
npm run dev
```

Build static files

```shell
npm run build
```

## Build automatically and publishment

If you want build automatically and publish the site contents, 
see this instruction 

[Running static site builds with GitHub Actions and Contentful \| Contentful](https://www.contentful.com/blog/2020/06/01/running-static-site-builds-with-github-actions-and-contentful/)
