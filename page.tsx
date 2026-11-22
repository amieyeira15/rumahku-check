"use client";
import {useState} from "react";
import {useRouter} from "next/navigation";
import {supabase} from "@/lib/supabase";

export default function AdminLogin(){
 const [email,setEmail]=useState(""),[password,setPassword]=useState(""),[error,setError]=useState(""),[busy,setBusy]=useState(false);
 const router=useRouter();
 async function login(e:React.FormEvent){e.preventDefault();if(!supabase){setError("Supabase belum dikonfigurasi. Sila lengkapkan .env.local.");return}setBusy(true);setError("");const {error}=await supabase.auth.signInWithPassword({email,password});setBusy(false);if(error){setError(error.message);return}router.push("/admin/dashboard")}
 return <main className="wrap" style={{maxWidth:520}}><a className="brand" href="/">RUMAHKU <span>CHECK</span></a><div className="panel" style={{marginTop:30}}><h1>Admin Login</h1><p className="muted">Akses pemilik sistem sahaja.</p><form onSubmit={login}><div className="field"><label>Email admin</label><input type="email" required value={email} onChange={e=>setEmail(e.target.value)}/></div><div className="field"><label>Kata laluan</label><input type="password" required value={password} onChange={e=>setPassword(e.target.value)}/></div>{error&&<p style={{color:"#a83d36"}}>{error}</p>}<button className="btn" disabled={busy}>{busy?"Sedang log masuk...":"Log masuk"}</button></form></div></main>
}
