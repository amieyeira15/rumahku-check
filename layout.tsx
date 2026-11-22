import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "RumahKu Check | Semak Kemampuan & Cari Rumah",
  description: "Semak anggaran kemampuan kewangan dan cari rumah yang sepadan."
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return <html lang="ms"><body>{children}</body></html>;
}
