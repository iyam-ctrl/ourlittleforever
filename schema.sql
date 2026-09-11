-- OUR LITTLE FOREVER V3 — Supabase setup
create table if not exists public.memories (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 title text,
 caption text,
 media_url text not null,
 media_type text not null check(media_type in ('image','video')),
 created_at timestamptz not null default now()
);

alter table public.memories enable row level security;

drop policy if exists "Users read own memories" on public.memories;
create policy "Users read own memories" on public.memories
for select to authenticated using (auth.uid() = user_id);

drop policy if exists "Users insert own memories" on public.memories;
create policy "Users insert own memories" on public.memories
for insert to authenticated with check (auth.uid() = user_id);

drop policy if exists "Users update own memories" on public.memories;
create policy "Users update own memories" on public.memories
for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "Users delete own memories" on public.memories;
create policy "Users delete own memories" on public.memories
for delete to authenticated using (auth.uid() = user_id);

insert into storage.buckets(id,name,public)
values('memories','memories',true)
on conflict(id) do nothing;

drop policy if exists "Users upload own files" on storage.objects;
create policy "Users upload own files" on storage.objects
for insert to authenticated
with check (bucket_id='memories' and (storage.foldername(name))[1]=auth.uid()::text);

drop policy if exists "Users read own files" on storage.objects;
create policy "Users read own files" on storage.objects
for select to authenticated
using (bucket_id='memories' and (storage.foldername(name))[1]=auth.uid()::text);

drop policy if exists "Users delete own files" on storage.objects;
create policy "Users delete own files" on storage.objects
for delete to authenticated
using (bucket_id='memories' and (storage.foldername(name))[1]=auth.uid()::text);
