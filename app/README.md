# Title

A very simple library management system.

## Description

The Library Management Database project is an advanced system for managing a library's resources and operations. It is designed to efficiently handle a wide array of tasks, including the organization and tracking of books, authors, publishers, and borrowers. The database is equipped with various features such as book reservations, checkouts, and returns, allowing for seamless management of the library's inventory and lending processes.

## API Reference

### Authors

| Endpoint Path        | Methods    | Parameters      |
| -------------------- | ---------- | --------------- |
| /authors             | GET        | N/A             |
| /authors/{author_id} | GET        | author_id       |
| /authors             | POST       | name            |
| /authors/{author_id} | DELETE     | author_id       |
| /authors/{author_id} | PUT, PATCH | author_id, name |

### Books

| Endpoint Path          | Methods    | Parameters                                                                        |
| ---------------------- | ---------- | --------------------------------------------------------------------------------- |
| /books                 | GET        | N/A                                                                               |
| /books/{book_id}       | GET        | book_id                                                                           |
| /books                 | POST       | isbn, title, year_published, book_count, authors, publishers, categories          |
| /books/{book_id}       | DELETE     | book_id                                                                           |
| /books/{book_id}       | PUT, PATCH | book_id, isbn, title, year_published, book_count, authors, publishers, categories |
| /books/{category_name} | GET        | category_name                                                                     |

### Categories

| Endpoint Path             | Methods    | Parameters        |
| ------------------------- | ---------- | ----------------- |
| /categories               | GET        | N/A               |
| /categories/{category_id} | GET        | category_id       |
| /categories               | POST       | name              |
| /categories/{category_id} | DELETE     | category_id       |
| /categories/{category_id} | PUT, PATCH | category_id, name |

### Checkouts

| Endpoint Path            | Methods    | Parameters                                           |
| ------------------------ | ---------- | ---------------------------------------------------- |
| /checkouts               | GET        | N/A                                                  |
| /checkouts/{checkout_id} | GET        | checkout_id                                          |
| /checkouts               | POST       | checkout_date, return_date, customer_id              |
| /checkouts/{checkout_id} | DELETE     | checkout_id                                          |
| /checkouts/{checkout_id} | PUT, PATCH | checkout_id, checkout_date, return_date, customer_id |

### Customers

| Endpoint Path                         | Methods    | Parameters        |
| ------------------------------------- | ---------- | ----------------- |
| /customers                            | GET        | N/A               |
| /customers/{customer_id}              | GET        | customer_id       |
| /customers                            | POST       | name              |
| /customers/{customer_id}              | DELETE     | customer_id       |
| /customers/{customer_id}              | PUT, PATCH | customer_id, name |
| /customers/{customer_id}/checkouts    | GET        | customer_id       |
| /customers/{customer_id}/reservations | GET        | customer_id       |

### Publishers

| Endpoint Path              | Methods    | Parameters         |
| -------------------------- | ---------- | ------------------ |
| /publishers                | GET        | N/A                |
| /publishers/{publisher_id} | GET        | publisher_id       |
| /publishers                | POST       | name               |
| /publishers/{publisher_id} | DELETE     | publisher_id       |
| /publishers/{publisher_id} | PUT, PATCH | publisher_id, name |

### Reservations

| Endpoint Path                  | Methods    | Parameters                                    |
| ------------------------------ | ---------- | --------------------------------------------- |
| /reservations                  | GET        | N/A                                           |
| /reservations/{reservation_id} | GET        | reservation_id                                |
| /reservations                  | POST       | reservation_date, customer_id                 |
| /reservations/{reservation_id} | DELETE     | reservation_id                                |
| /reservations/{reservation_id} | PUT, PATCH | reservation_id, reservation_date, customer_id |

## Retrospective

### How did the project's design evolve over time?

The project was initially designed with only the essential entities as the foundational elements (books, authors, publishers, categories). These entities formed the basic structure of the entire project. Subsequently, I incorporated the checkout and reservation entities to add a layer of complexity, although I did not add many attributes.

### Did you choose to use an ORM or raw SQL? Why?

I chose to use an ORM to gain a better understanding of how it works and to leverage its capabilities for efficient and standardized database management.

### What future improvements are in store, if any?

The future improvements for the project include adding more attributes to the customer entity to prevent identity theft, enhancing attributes in checkouts and reservations, and implementing additional functionality, such as penalties for customers with frequent overdue checkouts. Furthermore, establishing connections between books and checkouts/reservations will be a crucial focus for the upcoming updates
