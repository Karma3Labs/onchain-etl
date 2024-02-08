--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5 (Debian 15.5-1.pgdg120+1)
-- Dumped by pg_dump version 15.5 (Ubuntu 15.5-1.pgdg22.04+1)

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
-- Name: blocks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blocks (
    number bigint NOT NULL,
    hash character varying(255) NOT NULL,
    parent_hash character varying(255),
    nonce character varying(18),
    sha3_uncles character varying(255),
    logs_bloom text,
    transactions_root character varying(255),
    state_root character varying(255),
    receipts_root character varying(255),
    miner character varying(255),
    difficulty numeric,
    total_difficulty numeric,
    size bigint,
    extra_data text,
    gas_limit bigint,
    gas_used bigint,
    "timestamp" bigint,
    transaction_count integer,
    base_fee_per_gas bigint,
    withdrawals_root character varying(255),
    withdrawals text
);


ALTER TABLE public.blocks OWNER TO postgres;

--
-- Name: ens_addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ens_addresses (
    address character varying(255) NOT NULL,
    name character varying(65025),
    blockchain character varying(50),
    updated_at timestamp without time zone
);


ALTER TABLE public.ens_addresses OWNER TO postgres;

--
-- Name: labeled_addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.labeled_addresses (
    address character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    blockchain character varying(100) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.labeled_addresses OWNER TO postgres;

--
-- Name: transaction_sums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction_sums (
    from_address character varying(42) NOT NULL,
    to_address character varying(42),
    min_timestamp timestamp without time zone NOT NULL,
    max_timestamp timestamp without time zone NOT NULL,
    gas_price bigint NOT NULL,
    gas_used bigint NOT NULL,
    txn_value numeric NOT NULL,
    to_address_is_contract boolean NOT NULL,
    to_address_is_erc20 boolean NOT NULL,
    to_address_is_erc721 boolean NOT NULL
);


ALTER TABLE public.transaction_sums OWNER TO postgres;

--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    hash character varying(255) NOT NULL,
    nonce bigint,
    block_hash character varying(255),
    block_number bigint,
    transaction_index integer,
    from_address character varying(255),
    to_address character varying(255),
    value numeric,
    gas bigint,
    gas_price bigint,
    input text,
    block_timestamp bigint,
    max_fee_per_gas bigint,
    max_priority_fee_per_gas bigint,
    transaction_type integer
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: blocks blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (number);


--
-- Name: ens_addresses ens_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ens_addresses
    ADD CONSTRAINT ens_addresses_pkey PRIMARY KEY (address);


--
-- Name: labeled_addresses labeled_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labeled_addresses
    ADD CONSTRAINT labeled_addresses_pkey PRIMARY KEY (address, name);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (hash);


--
-- Name: idx_block_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_block_number ON public.transactions USING btree (block_number);


--
-- Name: idx_ens_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ens_name ON public.ens_addresses USING btree (name);


--
-- Name: idx_from_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_from_address ON public.transactions USING btree (from_address);


--
-- Name: idx_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_hash ON public.blocks USING btree (hash);


--
-- Name: idx_miner; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_miner ON public.blocks USING btree (miner);


--
-- Name: idx_to_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_to_address ON public.transactions USING btree (to_address);


--
-- PostgreSQL database dump complete
--

