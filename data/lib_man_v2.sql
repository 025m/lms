--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authors (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authors OWNER TO postgres;

--
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authors_id_seq OWNER TO postgres;

--
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.authors_id_seq OWNED BY public.authors.id;


--
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    id integer NOT NULL,
    isbn character varying(17) NOT NULL,
    title text NOT NULL,
    year_published smallint,
    book_count integer NOT NULL
);


ALTER TABLE public.books OWNER TO postgres;

--
-- Name: books_authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books_authors (
    book_id integer NOT NULL,
    author_id integer NOT NULL
);


ALTER TABLE public.books_authors OWNER TO postgres;

--
-- Name: books_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books_categories (
    book_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.books_categories OWNER TO postgres;

--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.books_id_seq OWNER TO postgres;

--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- Name: books_publishers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books_publishers (
    book_id integer NOT NULL,
    publisher_id integer NOT NULL
);


ALTER TABLE public.books_publishers OWNER TO postgres;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: checkouts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.checkouts (
    id integer NOT NULL,
    checkout_date date NOT NULL,
    return_date date NOT NULL,
    customer_id integer NOT NULL
);


ALTER TABLE public.checkouts OWNER TO postgres;

--
-- Name: checkouts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.checkouts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.checkouts_id_seq OWNER TO postgres;

--
-- Name: checkouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.checkouts_id_seq OWNED BY public.checkouts.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_id_seq OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: publishers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publishers (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.publishers OWNER TO postgres;

--
-- Name: publishers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publishers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publishers_id_seq OWNER TO postgres;

--
-- Name: publishers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publishers_id_seq OWNED BY public.publishers.id;


--
-- Name: reservations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservations (
    id integer NOT NULL,
    reservation_date date NOT NULL,
    customer_id integer NOT NULL
);


ALTER TABLE public.reservations OWNER TO postgres;

--
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservations_id_seq OWNER TO postgres;

--
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservations_id_seq OWNED BY public.reservations.id;


--
-- Name: authors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors ALTER COLUMN id SET DEFAULT nextval('public.authors_id_seq'::regclass);


--
-- Name: books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: checkouts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checkouts ALTER COLUMN id SET DEFAULT nextval('public.checkouts_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: publishers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishers ALTER COLUMN id SET DEFAULT nextval('public.publishers_id_seq'::regclass);


--
-- Name: reservations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations ALTER COLUMN id SET DEFAULT nextval('public.reservations_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
\.


--
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authors (id, name) FROM stdin;
1	James Lopez MD
2	Tina Mcdonald
3	Hannah Warren
4	James Braun
5	Victoria Mcdaniel
6	Madison Rodriguez
7	Logan Torres
8	Richard Lopez
9	Teresa Morris
10	Ashley Villarreal
34	J. K. Rowling
35	Max Martinez
\.


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books (id, isbn, title, year_published, book_count) FROM stdin;
2	978-0-379-18186-9	International scene along.	2011	50
3	978-1-79916-210-0	Its edge run firm better.	2012	17
4	978-1-71604-099-3	Support any mind conference particularly.	1901	47
5	978-1-100-40240-6	Describe your its court buy research art.	1930	54
6	978-1-75591-099-8	Assume trial worry. Sense no bank senior.	2011	51
7	978-0-253-50755-6	Bar situation degree believe.	1993	88
8	978-1-130-34079-2	Kind it wonder today image should success.	2010	82
9	978-0-19-681594-7	Or hair thank approach provide.	1993	7
10	978-1-968353-77-3	Girl half military over.	1904	37
11	978-0-7155-0370-6	Clear seem among certainly before.	1984	41
12	978-0-372-05059-9	After draw gas various fear.	1941	26
13	978-0-344-14408-0	Among success officer environmental bed.	1973	10
14	978-1-137-98068-7	Instead deep person dog be continue its money.	1998	23
15	978-1-71536-479-3	Maintain or tend sing budget.	1969	4
16	978-1-5247-1352-2	Bill rule customer many third amount save.	1951	97
17	978-0-655-77629-1	According region two.	2010	33
18	978-1-108-83186-4	Technology win example arm similar produce.	1988	17
19	978-1-4888-4107-1	The fly writer along understand item hospital.	1937	80
20	978-1-872280-90-5	Drug even major themselves notice month.	1917	5
37	978-6-073193-00-9	Harry Potter and the Philosopher's Stone	1997	1
1	978-0-9586577-9-2	Pattern police including soon.	1914	45
\.


--
-- Data for Name: books_authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books_authors (book_id, author_id) FROM stdin;
1	8
2	4
3	7
4	5
5	10
6	9
7	7
8	6
9	9
10	7
11	5
12	8
12	5
12	3
13	5
14	8
15	3
15	7
15	10
16	3
17	3
18	6
19	8
20	5
37	34
\.


--
-- Data for Name: books_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books_categories (book_id, category_id) FROM stdin;
1	1
2	1
3	5
3	1
4	1
4	5
5	4
6	1
7	1
8	4
9	4
9	5
10	5
10	1
11	2
12	2
13	4
14	5
15	2
16	5
17	4
18	4
19	5
20	1
20	2
37	4
37	34
\.


--
-- Data for Name: books_publishers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books_publishers (book_id, publisher_id) FROM stdin;
1	4
2	2
3	1
4	1
4	4
5	2
6	4
7	3
8	4
9	2
9	1
10	2
10	4
11	5
12	4
12	5
13	5
13	4
14	5
15	2
16	1
16	3
17	2
18	1
18	2
19	2
20	2
20	4
37	34
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name) FROM stdin;
1	Mystery
2	Romance
3	Science Fiction
4	Fantasy
5	Biography
34	Adventure
36	updated category
\.


--
-- Data for Name: checkouts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.checkouts (id, checkout_date, return_date, customer_id) FROM stdin;
35	2023-10-10	2023-11-01	2
1	2023-10-09	2023-11-14	11
2	2023-10-05	2023-11-16	3
3	2023-10-11	2023-10-31	10
4	2023-10-26	2023-11-01	1
5	2023-10-29	2023-11-04	15
6	2023-10-09	2023-11-25	13
7	2023-10-07	2023-11-23	7
8	2023-10-22	2023-11-25	13
9	2023-10-28	2023-11-03	9
10	2023-10-21	2023-11-16	10
11	2023-10-23	2023-11-04	8
12	2023-10-01	2023-11-10	7
13	2023-10-24	2023-11-07	5
14	2023-10-24	2023-11-13	5
15	2023-10-31	2023-11-29	11
16	2023-10-11	2023-11-06	10
17	2023-10-28	2023-11-27	12
18	2023-10-14	2023-11-26	11
19	2023-10-02	2023-10-31	3
20	2023-10-26	2023-11-21	5
21	2023-10-17	2023-11-15	15
22	2023-10-16	2023-11-26	9
23	2023-10-05	2023-11-28	8
24	2023-10-17	2023-11-20	6
25	2023-10-17	2023-11-03	11
26	2023-10-30	2023-11-18	5
27	2023-10-10	2023-11-12	3
28	2023-10-16	2023-11-19	6
29	2023-10-01	2023-11-30	2
30	2023-10-16	2023-11-30	6
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, name) FROM stdin;
1	Natalie Cherry
2	Ricardo Smith
3	Scott Dawson
4	Daniel Alexander
5	Brett Tucker
6	Garrett Stewart
7	Roy Mcguire
8	Steven Gonzalez
9	Colton Davis
10	Andrea Key
11	Joseph Lopez
12	Deborah Wall
13	Sylvia Serrano
14	Joseph Moore
15	Abigail Yu
34	Monkey Destiny Luffy
\.


--
-- Data for Name: publishers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publishers (id, name) FROM stdin;
1	Wade, Butler and Hill
2	Suarez, Spencer and Mcclain
3	Mitchell PLC
4	Turner-Butler
5	Armstrong LLC
34	Pottermore Publishing
35	Martinez Publishers
\.


--
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservations (id, reservation_date, customer_id) FROM stdin;
1	2023-11-02	2
2	2023-11-02	7
3	2023-11-20	10
4	2023-11-03	8
5	2023-11-03	2
6	2023-11-19	9
7	2023-11-08	4
8	2023-11-26	3
9	2023-11-22	5
10	2023-11-20	10
11	2023-11-07	3
12	2023-11-30	11
13	2023-11-24	1
14	2023-11-13	13
15	2023-10-31	2
16	2023-11-07	4
17	2023-11-10	10
18	2023-11-27	8
19	2023-11-05	9
20	2023-11-11	3
\.


--
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authors_id_seq', 35, true);


--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_id_seq', 70, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 36, true);


--
-- Name: checkouts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.checkouts_id_seq', 36, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 35, true);


--
-- Name: publishers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publishers_id_seq', 35, true);


--
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservations_id_seq', 34, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: authors authors_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_name_key UNIQUE (name);


--
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- Name: books_authors books_authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books_authors
    ADD CONSTRAINT books_authors_pkey PRIMARY KEY (book_id, author_id);


--
-- Name: books_categories books_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books_categories
    ADD CONSTRAINT books_categories_pkey PRIMARY KEY (book_id, category_id);


--
-- Name: books books_isbn_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_isbn_key UNIQUE (isbn);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: books_publishers books_publishers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books_publishers
    ADD CONSTRAINT books_publishers_pkey PRIMARY KEY (book_id, publisher_id);


--
-- Name: books books_title_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_title_key UNIQUE (title);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: checkouts checkouts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checkouts
    ADD CONSTRAINT checkouts_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: publishers publishers_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishers
    ADD CONSTRAINT publishers_name_key UNIQUE (name);


--
-- Name: publishers publishers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishers
    ADD CONSTRAINT publishers_pkey PRIMARY KEY (id);


--
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- Name: checkouts fk_checkouts_customers; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checkouts
    ADD CONSTRAINT fk_checkouts_customers FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: reservations fk_reservations_customers; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT fk_reservations_customers FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- PostgreSQL database dump complete
--

