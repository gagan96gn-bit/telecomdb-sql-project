# TelecomDB — Telecom Billing System (SQL)

A fully normalized relational database for a telecom billing system, designed from scratch in MySQL.

## Overview
Models the full customer lifecycle for a telecom provider: customer records, plans, subscriptions, usage tracking, billing, and payments.

## Schema
6 tables with foreign key constraints, normalized to 3NF:
- **Customer** — customer records and status
- **Plan** — prepaid/postpaid plan definitions and rates
- **Subscription** — links customers to plans
- **UsageRecord** — call/SMS/data usage logs
- **Billing** — monthly bill generation
- **Payment** — payment records linked to bills

## Queries included
- Active customer lookups
- Active subscriptions joined with customer and plan details
- Usage history per subscription
- Billing summaries joined across customer, subscription, and billing tables
- High-value bill filtering (bills over a threshold)
- Unpaid account detection

## Tools
MySQL, MySQL Workbench

## How to run
1. Run the script in MySQL Workbench or any MySQL client
2. Creates the database, tables, constraints, sample data, then runs the analysis queries
