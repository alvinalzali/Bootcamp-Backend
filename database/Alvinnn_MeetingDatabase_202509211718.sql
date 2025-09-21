--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-09-21 17:18:34

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 224 (class 1259 OID 24625)
-- Name: participant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participant (
    id integer NOT NULL,
    user_id integer,
    meeting_id integer,
    join_time timestamp without time zone,
    leave_time timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.participant OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24624)
-- Name: participant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.participant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.participant_id_seq OWNER TO postgres;

--
-- TOC entry 4967 (class 0 OID 0)
-- Dependencies: 223
-- Name: participant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.participant_id_seq OWNED BY public.participant.id;


--
-- TOC entry 220 (class 1259 OID 24602)
-- Name: plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plan (
    id integer NOT NULL,
    plan_name character varying(50),
    max_participant smallint,
    price integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.plan OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24601)
-- Name: plan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.plan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.plan_id_seq OWNER TO postgres;

--
-- TOC entry 4968 (class 0 OID 0)
-- Dependencies: 219
-- Name: plan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plan_id_seq OWNED BY public.plan.id;


--
-- TOC entry 226 (class 1259 OID 24644)
-- Name: premiumusers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.premiumusers (
    id integer NOT NULL,
    user_id integer,
    plan_id integer,
    subscription_start timestamp without time zone,
    subscription_end timestamp without time zone,
    payment_status smallint,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.premiumusers OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24643)
-- Name: premiumusers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.premiumusers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.premiumusers_id_seq OWNER TO postgres;

--
-- TOC entry 4969 (class 0 OID 0)
-- Dependencies: 225
-- Name: premiumusers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.premiumusers_id_seq OWNED BY public.premiumusers.id;


--
-- TOC entry 228 (class 1259 OID 24663)
-- Name: recordcloud; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recordcloud (
    id integer NOT NULL,
    meeting_id integer,
    chatfile character varying(255),
    videofile character varying(255),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.recordcloud OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24662)
-- Name: recordcloud_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recordcloud_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recordcloud_id_seq OWNER TO postgres;

--
-- TOC entry 4970 (class 0 OID 0)
-- Dependencies: 227
-- Name: recordcloud_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recordcloud_id_seq OWNED BY public.recordcloud.id;


--
-- TOC entry 222 (class 1259 OID 24611)
-- Name: roommeeting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roommeeting (
    id integer NOT NULL,
    password smallint NOT NULL,
    plan_id integer,
    record boolean,
    timestart timestamp without time zone,
    timeend timestamp without time zone,
    createdbyuser integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.roommeeting OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24610)
-- Name: roommeeting_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roommeeting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roommeeting_id_seq OWNER TO postgres;

--
-- TOC entry 4971 (class 0 OID 0)
-- Dependencies: 221
-- Name: roommeeting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roommeeting_id_seq OWNED BY public.roommeeting.id;


--
-- TOC entry 218 (class 1259 OID 24590)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    name character varying(100),
    role smallint,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24589)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4972 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4776 (class 2604 OID 24628)
-- Name: participant id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participant ALTER COLUMN id SET DEFAULT nextval('public.participant_id_seq'::regclass);


--
-- TOC entry 4770 (class 2604 OID 24605)
-- Name: plan id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plan ALTER COLUMN id SET DEFAULT nextval('public.plan_id_seq'::regclass);


--
-- TOC entry 4779 (class 2604 OID 24647)
-- Name: premiumusers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.premiumusers ALTER COLUMN id SET DEFAULT nextval('public.premiumusers_id_seq'::regclass);


--
-- TOC entry 4782 (class 2604 OID 24666)
-- Name: recordcloud id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recordcloud ALTER COLUMN id SET DEFAULT nextval('public.recordcloud_id_seq'::regclass);


--
-- TOC entry 4773 (class 2604 OID 24614)
-- Name: roommeeting id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roommeeting ALTER COLUMN id SET DEFAULT nextval('public.roommeeting_id_seq'::regclass);


--
-- TOC entry 4767 (class 2604 OID 24593)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4957 (class 0 OID 24625)
-- Dependencies: 224
-- Data for Name: participant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participant (id, user_id, meeting_id, join_time, leave_time, created_at, updated_at) FROM stdin;
1	1	2	2025-09-20 10:35:00	2025-09-20 11:20:00	2025-09-21 17:12:01.962843	2025-09-21 17:12:01.962843
2	2	2	2025-09-20 10:30:00	2025-09-20 11:30:00	2025-09-21 17:12:01.962843	2025-09-21 17:12:01.962843
3	4	2	2025-09-20 10:40:00	2025-09-20 11:15:00	2025-09-21 17:12:01.962843	2025-09-21 17:12:01.962843
4	2	3	2025-09-22 09:05:00	2025-09-22 09:50:00	2025-09-21 17:12:01.962843	2025-09-21 17:12:01.962843
\.


--
-- TOC entry 4953 (class 0 OID 24602)
-- Dependencies: 220
-- Data for Name: plan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plan (id, plan_name, max_participant, price, created_at, updated_at) FROM stdin;
1	Paket Dasar	10	50000	2025-09-21 17:12:01.962843	2025-09-21 17:12:01.962843
2	Paket Premium	50	150000	2025-09-21 17:12:01.962843	2025-09-21 17:12:01.962843
3	Paket Bisnis	200	500000	2025-09-21 17:12:01.962843	2025-09-21 17:12:01.962843
\.


--
-- TOC entry 4959 (class 0 OID 24644)
-- Dependencies: 226
-- Data for Name: premiumusers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.premiumusers (id, user_id, plan_id, subscription_start, subscription_end, payment_status, created_at, updated_at) FROM stdin;
1	1	3	2025-09-01 00:00:00	2025-10-01 00:00:00	1	2025-09-21 17:12:01.962843	2025-09-21 17:12:01.962843
2	4	2	2025-09-15 00:00:00	2025-10-15 00:00:00	1	2025-09-21 17:12:01.962843	2025-09-21 17:12:01.962843
\.


--
-- TOC entry 4961 (class 0 OID 24663)
-- Dependencies: 228
-- Data for Name: recordcloud; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recordcloud (id, meeting_id, chatfile, videofile, created_at, updated_at) FROM stdin;
1	2	file_chat_joko_prasetyo_rapat_2_2025-09-22.txt	file_video_joko_prasetyo_rapat_2_2025-09-22.mp4	2025-09-21 17:12:01.962843	2025-09-21 17:12:01.962843
\.


--
-- TOC entry 4955 (class 0 OID 24611)
-- Dependencies: 222
-- Data for Name: roommeeting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roommeeting (id, password, plan_id, record, timestart, timeend, createdbyuser, created_at, updated_at) FROM stdin;
1	1234	1	f	2025-09-21 14:00:00	2025-09-21 15:00:00	2	2025-09-21 17:12:01.962843	2025-09-21 17:12:01.962843
2	5678	2	t	2025-09-20 10:30:00	2025-09-20 11:30:00	3	2025-09-21 17:12:01.962843	2025-09-21 17:12:01.962843
3	9101	3	f	2025-09-22 09:00:00	2025-09-22 10:00:00	1	2025-09-21 17:12:01.962843	2025-09-21 17:12:01.962843
\.


--
-- TOC entry 4951 (class 0 OID 24590)
-- Dependencies: 218
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, name, role, created_at, updated_at) FROM stdin;
1	budi.santoso@gmail.com	d44bb418088a144235b997d05ee688d8c5ddadeea1f69dc3098cdd7a6fd11682	Budi Santoso	2	2025-09-21 17:12:01.962843	2025-09-21 17:12:01.962843
2	siti.amalia@gmail.com	849fa0a9b23995ff20d0f8c71bf8151eea99bba0680e2d1f3165c32befd8d719	Siti Amalia	1	2025-09-21 17:12:01.962843	2025-09-21 17:12:01.962843
3	joko.prasetyo@gmail.com	c432b8fcbeedf4cff960803e78996ab50542697ec60a2c17699ce182784ffa8f	Joko Prasetyo	1	2025-09-21 17:12:01.962843	2025-09-21 17:12:01.962843
4	indah.kusuma@gmail.com	154531a3b683cebcd5980c1398906a0f12a460ca18405fe2ab8e7c41c71eba79	Indah Kusuma	1	2025-09-21 17:12:01.962843	2025-09-21 17:12:01.962843
\.


--
-- TOC entry 4973 (class 0 OID 0)
-- Dependencies: 223
-- Name: participant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.participant_id_seq', 4, true);


--
-- TOC entry 4974 (class 0 OID 0)
-- Dependencies: 219
-- Name: plan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plan_id_seq', 3, true);


--
-- TOC entry 4975 (class 0 OID 0)
-- Dependencies: 225
-- Name: premiumusers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.premiumusers_id_seq', 2, true);


--
-- TOC entry 4976 (class 0 OID 0)
-- Dependencies: 227
-- Name: recordcloud_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recordcloud_id_seq', 1, true);


--
-- TOC entry 4977 (class 0 OID 0)
-- Dependencies: 221
-- Name: roommeeting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roommeeting_id_seq', 3, true);


--
-- TOC entry 4978 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- TOC entry 4794 (class 2606 OID 24632)
-- Name: participant participant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participant
    ADD CONSTRAINT participant_pkey PRIMARY KEY (id);


--
-- TOC entry 4790 (class 2606 OID 24609)
-- Name: plan plan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plan
    ADD CONSTRAINT plan_pkey PRIMARY KEY (id);


--
-- TOC entry 4796 (class 2606 OID 24651)
-- Name: premiumusers premiumusers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.premiumusers
    ADD CONSTRAINT premiumusers_pkey PRIMARY KEY (id);


--
-- TOC entry 4798 (class 2606 OID 24672)
-- Name: recordcloud recordcloud_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recordcloud
    ADD CONSTRAINT recordcloud_pkey PRIMARY KEY (id);


--
-- TOC entry 4792 (class 2606 OID 24618)
-- Name: roommeeting roommeeting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roommeeting
    ADD CONSTRAINT roommeeting_pkey PRIMARY KEY (id);


--
-- TOC entry 4786 (class 2606 OID 24599)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4788 (class 2606 OID 24597)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4800 (class 2606 OID 24638)
-- Name: participant participant_meeting_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participant
    ADD CONSTRAINT participant_meeting_id_fkey FOREIGN KEY (meeting_id) REFERENCES public.roommeeting(id) ON DELETE CASCADE;


--
-- TOC entry 4801 (class 2606 OID 24633)
-- Name: participant participant_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participant
    ADD CONSTRAINT participant_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4802 (class 2606 OID 24657)
-- Name: premiumusers premiumusers_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.premiumusers
    ADD CONSTRAINT premiumusers_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plan(id) ON DELETE CASCADE;


--
-- TOC entry 4803 (class 2606 OID 24652)
-- Name: premiumusers premiumusers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.premiumusers
    ADD CONSTRAINT premiumusers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4804 (class 2606 OID 24673)
-- Name: recordcloud recordcloud_meeting_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recordcloud
    ADD CONSTRAINT recordcloud_meeting_id_fkey FOREIGN KEY (meeting_id) REFERENCES public.roommeeting(id) ON DELETE CASCADE;


--
-- TOC entry 4799 (class 2606 OID 24619)
-- Name: roommeeting roommeeting_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roommeeting
    ADD CONSTRAINT roommeeting_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plan(id) ON DELETE CASCADE;


-- Completed on 2025-09-21 17:18:34

--
-- PostgreSQL database dump complete
--

