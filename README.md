# Graphql with mojolicious

An experiment to try graphql with mojolicious perl framework.

FYI ```Course``` is an application name.

### Start Application

```sh
./script/course daemon
```

### URL for graphql query

```sh
http://127.0.0.1:3000/graphql
http://127.0.0.1:3000/graphql_query
```

```sh
{
  courses {
    id
    name
  }
}
```

```sh
{
  courses {
    id
    name
    author {
      id
    }
  }
}

```

```sh
{
  course(id: "1") {
    id
    name
  }
}
```

```sh
mutation {
  addCourse(name:"Course 3", user_id:"b") {
    name
    id
  }
}
```

```sh
{
  users {
    name
  }
}
```

```sh
{
  user(id: "a") {
    name
  }
}

```


### Flat file database

```sh
/lib/Course/Model/DB.pm
/lib/Course/Model/Schema.pm
```

```sh
		a => { id => 'a', name => 'alice' },
		b => { id => 'b', name => 'bob' },
```