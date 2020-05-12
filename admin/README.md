Maid Cafe Admin
====

module not real-time to create/update/delete information sent to maid and kitchen apps.

# Using Docker

You only need to run:

```
$ docker-compose up
```

# Installation

Create Pipenv env:

```
pipenv install
```

* development

Activate env:

```
pipenv shell
```

Execute migrations:

```
python manage.py migrate
```

Run server:

```
python manage.py runserver
```

open http://localhost:8000/admin and try it.
