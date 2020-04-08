# Graphql with mojolicious

An experiment to try graphql with mojolicious perl framework.

FYI ```Course``` is an application name.

### Start Application

```sh
./script/course daemon
```

### URL for graphql query

```sh
http://127.0.0.1:3000/graphql_query
```

```sh
    {
        user(id: "b") {
            name
            id
        }
    }
```

### Flat file database

```sh
/lib/Course/Model/DB.pm
```

```sh
		a => { id => 'a', name => 'alice' },
		b => { id => 'b', name => 'bob' },
```