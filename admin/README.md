Maid Cafe Admin
====

module not real-time to create/update/delete information sent to maid and kitchen apps.

# Using Docker

You only need to run:

```
$ docker-compose up
```

# Installation

Create virtualenv:

```
virtualenv -p /usr/bin/python3 venv
```

Activate virtualenv:

```
source venv/bin/activate
```

Install dependencies:

```
pip install -r requirements.txt
```

* development

Execute migrations:

```
python manage.py migrate
```

Run server:

```
python manage.py runserver
```

open http://localhost:8000/admin and try it.
