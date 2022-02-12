Dockerized JSON Server for arm64 v8
============


## Summary

Repository name in Docker Hub: **[masumonline/arm64-jsonserver](https://hub.docker.com/r/masumonline/arm64-jsonserver/)**

This repository contains Dockerized [JSON Server](https://github.com/typicode/json-server), published to the public [Docker Hub](https://hub.docker.com/) via **automated build** mechanism.



## Configuration

This docker image contains the following software stack:

- node:16.14-alpine3.14

- JSON Server

Total image size is less than 115 MB.


### Dependencies

- [`node:16.14-alpine3.14`](https://hub.docker.com/_/node/)


### History

- latest - Initial release.


## Installation

```
$ docker pull masumonline/arm64-jsonserver
```



## Usage

Create a `db.json` file in src folder with some data

```json
{
  "posts": [
    { "id": 1, "title": "json-server", "author": "typicode" }
  ],
  "comments": [
    { "id": 1, "body": "some comment", "postId": 1 }
  ],
  "profile": { "name": "typicode" }
}
```

#### Show usage

```
$ docker run --rm masumonline/arm64-jsonserver
```


#### Server example

```
$ docker run  \
      -p 3000:3000  -v `pwd`:/data  \
      masumonline/arm64-jsonserver        \
      --watch db.json
```
#### Docker compose
#### Create a docker-compose.yml
```
version: "3.3"

services:
  json:
    image: masumonline/arm64-jsonserver:latest
    ports:
      - "8080:3000"
    volumes:
      - ./src:/data
    command:
         --watch db.json
    networks:
      - json

networks:
  json:

```

### Plural routes

```
GET    /posts
GET    /posts/1
POST   /posts
PUT    /posts/1
PATCH  /posts/1
DELETE /posts/1
```

### Singular routes

```
GET    /profile                                                
POST   /profile
PUT    /profile
PATCH  /profile
```

### Filter

Use `.` to access deep properties

```
GET /posts?title=json-server&author=typicode
GET /posts?id=1&id=2
GET /comments?author.name=typicode
```

### Paginate

Use `_page` and optionally `_limit` to paginate returned data.

In the `Link` header you'll get `first`, `prev`, `next` and `last` links.


```
GET /posts?_page=7
GET /posts?_page=7&_limit=20
```

_10 items are returned by default_

### Sort

Add `_sort` and `_order` (ascending order by default)

```
GET /posts?_sort=views&_order=asc
GET /posts/1/comments?_sort=votes&_order=asc
```

For multiple fields, use the following format:

```
GET /posts?_sort=user,views&_order=desc,asc
```

### Slice

Add `_start` and `_end` or `_limit` (an `X-Total-Count` header is included in the response)

```
GET /posts?_start=20&_end=30
GET /posts/1/comments?_start=20&_end=30
GET /posts/1/comments?_start=20&_limit=10
```

_Works exactly as [Array.slice](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Array/slice) (i.e. `_start` is inclusive and `_end` exclusive)_

### Operators

Add `_gte` or `_lte` for getting a range

```
GET /posts?views_gte=10&views_lte=20
```

Add `_ne` to exclude a value

```
GET /posts?id_ne=1
```

Add `_like` to filter (RegExp supported)

```
GET /posts?title_like=server
```

### Full-text search

Add `q`

```
GET /posts?q=internet
```

### Relationships

To include children resources, add `_embed`

```
GET /posts?_embed=comments
GET /posts/1?_embed=comments
```

To include parent resource, add `_expand`

```
GET /comments?_expand=post
GET /comments/1?_expand=post
```

To get or create nested resources (by default one level, [add custom routes](#add-custom-routes) for more)

```
GET  /posts/1/comments
POST /posts/1/comments
```


#### Github Link
For Full Details checkout github Page [Arm64v8 JSON Server](https://github.com/masumonline/jsonserver).

#### More examples

Most examples documented in [JSON Server project site](https://github.com/typicode/json-server) will work.
