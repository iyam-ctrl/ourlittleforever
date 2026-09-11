# Our Little Forever V3 ♡

Versi dengan login + daftar akun Supabase Auth dan album private berbasis RLS.

1. Buat project Supabase.
2. Jalankan `schema.sql` di SQL Editor.
3. Isi `SUPABASE_URL` dan `SUPABASE_ANON_KEY` di `index.html`.
4. Jika email confirmation aktif, setelah daftar cek email lalu login.
5. Deploy `index.html` ke Vercel/Netlify/GitHub Pages.

Catatan: kebijakan RLS dan Storage membatasi data/file berdasarkan `auth.uid()`. Upload disimpan dalam folder user ID.
