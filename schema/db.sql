--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5 (Debian 15.5-1.pgdg120+1)
-- Dumped by pg_dump version 16.0

-- Started on 2024-02-08 12:23:39 PST

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
-- TOC entry 220 (class 1259 OID 20437)
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
-- TOC entry 224 (class 1259 OID 36989)
-- Name: contracts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contracts (
    address character varying(42) NOT NULL,
    is_erc20 boolean NOT NULL,
    is_erc721 boolean NOT NULL
);


ALTER TABLE public.contracts OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 45187)
-- Name: dune_labels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dune_labels (
    address character varying(255) NOT NULL,
    blockchain character varying(50) NOT NULL,
    category character varying(50) NOT NULL,
    label_type character varying(50) NOT NULL,
    name character varying(2000),
    model_name character varying(100),
    source character varying(100),
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.dune_labels OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 20591)
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
-- TOC entry 219 (class 1259 OID 16405)
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
-- TOC entry 223 (class 1259 OID 28794)
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
-- TOC entry 218 (class 1259 OID 16395)
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
-- TOC entry 3232 (class 2606 OID 20443)
-- Name: blocks blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (number);


--
-- TOC entry 3242 (class 2606 OID 36993)
-- Name: contracts contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_pkey PRIMARY KEY (address);


--
-- TOC entry 3244 (class 2606 OID 45194)
-- Name: dune_labels dune_labels_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dune_labels
    ADD CONSTRAINT dune_labels_addresses_pkey PRIMARY KEY (address, blockchain);


--
-- TOC entry 3236 (class 2606 OID 20597)
-- Name: ens_addresses ens_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ens_addresses
    ADD CONSTRAINT ens_addresses_pkey PRIMARY KEY (address);


--
-- TOC entry 3230 (class 2606 OID 16411)
-- Name: labeled_addresses labeled_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labeled_addresses
    ADD CONSTRAINT labeled_addresses_pkey PRIMARY KEY (address, name);


--
-- TOC entry 3227 (class 2606 OID 16401)
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (hash);


--
-- TOC entry 3223 (class 1259 OID 16404)
-- Name: idx_block_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_block_number ON public.transactions USING btree (block_number);


--
-- TOC entry 3237 (class 1259 OID 20601)
-- Name: idx_ens_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ens_name ON public.ens_addresses USING btree (name);


--
-- TOC entry 3224 (class 1259 OID 16402)
-- Name: idx_from_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_from_address ON public.transactions USING btree (from_address);


--
-- TOC entry 3233 (class 1259 OID 20444)
-- Name: idx_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_hash ON public.blocks USING btree (hash);


--
-- TOC entry 3228 (class 1259 OID 36986)
-- Name: idx_labeled_addresses_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_labeled_addresses_address ON public.labeled_addresses USING btree (address);


--
-- TOC entry 3245 (class 1259 OID 45192)
-- Name: idx_labels_addresses_hash_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_labels_addresses_hash_address ON public.dune_labels USING hash (address);


--
-- TOC entry 3234 (class 1259 OID 20445)
-- Name: idx_miner; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_miner ON public.blocks USING btree (miner);


--
-- TOC entry 3225 (class 1259 OID 16403)
-- Name: idx_to_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_to_address ON public.transactions USING btree (to_address);


--
-- TOC entry 3238 (class 1259 OID 36988)
-- Name: idx_transaction_sums_from_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transaction_sums_from_address ON public.transaction_sums USING btree (from_address);


--
-- TOC entry 3239 (class 1259 OID 37069)
-- Name: idx_transaction_sums_from_address_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transaction_sums_from_address_hash ON public.transaction_sums USING hash (from_address);


--
-- TOC entry 3240 (class 1259 OID 36987)
-- Name: idx_transaction_sums_to_address; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transaction_sums_to_address ON public.transaction_sums USING btree (to_address);


-- Completed on 2024-02-08 12:23:58 PST

--
-- PostgreSQL database dump complete
--

