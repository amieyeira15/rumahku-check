-- RumahKu Check database schema
create extension if not exists pgcrypto;

create table if not exists public.homes (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  price numeric(12,2) not null check (price > 0),
  location text not null,
  property_type text not null,
  bedrooms integer,
  bathrooms integer,
  tenure text,
  image_url text,
  description text,
  status text not null default 'available' check (status in ('available','booking','sold')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.leads (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  phone text not null,
  estimated_budget numeric(12,2),
  monthly_income numeric(12,2),
  monthly_commitments numeric(12,2),
  source text default 'RumahKu Check',
  consent_at timestamptz not null,
  created_at timestamptz not null default now()
);

alter table public.homes enable row level security;
alter table public.leads enable row level security;

-- Public visitors can see available listings only.
drop policy if exists "Public can read available homes" on public.homes;
create policy "Public can read available homes" on public.homes
for select to anon, authenticated using (status = 'available');

-- Admin role is assigned to your Supabase Auth user app_metadata.
drop policy if exists "Admin full access homes" on public.homes;
create policy "Admin full access homes" on public.homes
for all to authenticated
using ((auth.jwt()->'app_metadata'->>'role') = 'admin')
with check ((auth.jwt()->'app_metadata'->>'role') = 'admin');

-- Visitors can submit a lead only when consent_at is provided.
drop policy if exists "Visitors can submit consented leads" on public.leads;
create policy "Visitors can submit consented leads" on public.leads
for insert to anon, authenticated
with check (consent_at is not null);

drop policy if exists "Admin can read leads" on public.leads;
create policy "Admin can read leads" on public.leads
for select to authenticated
using ((auth.jwt()->'app_metadata'->>'role') = 'admin');

-- No public update/delete policies for leads.
create index if not exists homes_status_price_idx on public.homes(status, price);
create index if not exists leads_created_at_idx on public.leads(created_at desc);
