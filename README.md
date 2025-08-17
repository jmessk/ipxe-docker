# iPXE Docker

## DHCP Settings

## Build iPXE Bootloader

iPXE ブートを開始するためには、PXE ブートを用いて iPXE 用のブートローダを取得する必要があります。
そして、PXE ブートでは、ブートローダの取得に TFTP を利用します。

iPXE ブートローダのビルド、TFTP の配信は、コンテナで完結しています。
iPXE ブートローダは <https://github.com/ipxe/ipxe.git> から入手し、ビルドできます。

CPU アーキテクチャに応じて、異なるブートローダをビルドする必要があります。
しかし、コンテナで完結しているため、新たなブートローダを追加したい時以外は、特にビルドする必要はありません。

以下は参考です:

<https://ipxe.org/download>
<https://ipxe.org/appnote/buildtargets>

例: x86_64-efi のビルド

```bash
git clone https://github.com/ipxe/ipxe.git
cd ipxe/src/
make bin-x86_64-efi/ipxe.efi
```

## TFTP Server

iPXE ブートを開始するためには、PXE ブートを用いて iPXE 用のブートローダを取得する必要があります。
そして、PXE ブートでは、ブートローダの取得に TFTP を利用します。

先ほどビルドした iPXE ブートローダは、`/srv/tftp/` 以下に配置することで、TFTP サーバから配信できます。

例: `tftp://<host_ip>/ipxe-x86_64.efi`

相対パスでの配信がうまくいかなかったので、以下のページを参考にしました。

<https://tnishinaga.hatenablog.com/entry/2014/09/09/232006>

## HTTP Server

NGINX でブートローダ以外のファイルを配信します。`http-server/files/` 以下にファイルを配置すると、NGINX コンテナの `/var/www/html/` 以下にバインドマウントされ、HTTP で取得できます。

ディレクトリ構造がそのまま URL のパスになります。

例: `http://<host_ip>/iso/ubuntu-24.04.5-live-server-amd64.iso`

- `/boot.ipxe`: PXE ブート用の iPXE スクリプト。iPXE ブートした際に、インストール可能な OS の一覧などを表示するためのスクリプトです。
- `/iso/<os>.iso`: 各 OS の ISO ファイル。好きな OS の ISO ファイルを配置してください。
