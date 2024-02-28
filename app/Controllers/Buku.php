<?php

namespace App\Controllers;

use App\Models\M_model;

class Buku extends BaseController
{
    protected function checkAuth()
    {
        $id_user = session()->get('id');
        $level = session()->get('level');
        if ($id_user != null && $level == 'admin') {
            return true;
        } else {
            return false;
        }
    }

    protected function biasa()
    {
        $id_user = session()->get('id');
        $level = session()->get('level');
        if ($id_user != null ) {
            return true;
        } else {
            return false;
        }
    }

    public function index()
    {
         if (!$this->biasa()) {
            return redirect()->to(base_url('/home/dashboard'));
        }

        $model = new M_model();
        $data['data']= $model->tampil('buku');
        $data['kategori']= $model->relasiKategori();
        $where = array('userID'=> session()->get('id'));
        $data['koleksi']= $model->koleksi($where);
        echo view('buku/buku',$data);
        // print_r($data['kategori']);
    }

    public function input()
    {
         if (!$this->checkAuth()) {
            return redirect()->to(base_url('/home/dashboard'));
        }

        $model = new M_model();
        $data['data']= $model->tampil('kategoribuku');
        echo view('buku/input',$data);
    }

    public function aksi_input()
    {
         if (!$this->checkAuth()) {
            return redirect()->to(base_url('/home/dashboard'));
        }

        // print_r($this->request->getPost('kategori'));

       
        $judul=$this->request->getPost('judul');
        $penulis=$this->request->getPost('penulis');
        $penerbit=$this->request->getPost('penerbit');
        $tahun=$this->request->getPost('tahun');
        $kategori=$this->request->getPost('kategori');
        $maker_pegawai=session()->get('id');

        $buku=array(
            'judul'=>$judul,
            'penulis'=>$penulis,
            'penerbit'=>$penerbit,
            'tahunTerbit'=>$tahun,
        );

        $model=new M_model();
        $model->simpan('buku', $buku);
        $cek= $model->getRowArray('buku', $buku);

        foreach($kategori as $gori) {
            $kategori=array(
                'bukuID'=>$cek['bukuID'],
                'kategoriID'=>$gori,
               
            );
            $model->simpan('kategoribuku_relasi', $kategori);

        }

        
        $log = array(
            'isi_log' => 'user menambahkan data buku',
            'log_idUser' => $maker_pegawai,
            
        );

        $model->simpan('log', $log);
        return redirect()->to('/buku');

    }


    public function edit($id)
    {
         if (!$this->checkAuth()) {
            return redirect()->to(base_url('/home/dashboard'));
        }

        $model = new M_model();
        $data['buku']= $model->getRow('buku',['bukuID ' => $id]);
        echo view('buku/edit',$data);
    }

    public function aksi_edit()
    {
        if (!$this->checkAuth()) {
            return redirect()->to(base_url('/home/dashboard'));
        }
        $id= $this->request->getPost('id');    
        $judul=$this->request->getPost('judul');
        $penulis=$this->request->getPost('penulis');
        $penerbit=$this->request->getPost('penerbit');
        $tahun=$this->request->getPost('tahun');
        $kategori=$this->request->getPost('kategori');
        $maker_pegawai=session()->get('id');

        $buku=array(
            'judul'=>$judul,
            'penulis'=>$penulis,
            'penerbit'=>$penerbit,
            'tahunTerbit'=>$tahun,
        );

        $model=new M_model();
        $model->edit('buku', $buku, ['bukuID' => $id]);
      

        
        $log = array(
            'isi_log' => 'user menambahkan data buku',
            'log_idUser' => $maker_pegawai,
            
        );

        $model->simpan('log', $log);
        return redirect()->to('/buku');


    }

    public function hapus($id)
    {
    if (!$this->checkAuth()) {
        return redirect()->to(base_url('/home/dashboard'));
    }

        $model=new M_model();
        $where2=array('bukuID'=>$id);

        $model->hapus('buku',$where2);
        $model->hapus('kategoribuku_relasi',$where2);

        $log = array(
            'isi_log' => 'user menghapus data buku',
            'log_idUser' => session()->get('id'),
            
        );

        $model->simpan('log', $log);

        return redirect()->to('/buku');

        
    }

    public function ulasan($id)
{
    if (!$this->checkAuth()) {
        return redirect()->to(base_url('/home/dashboard'));
    }

        $model=new M_model();
        $on='ulasanbuku.bukuID=buku.bukuID';
        $on2='ulasanbuku.userID=user.id_user';
        $data['data']=$model->super_w('ulasanbuku', 'buku','user', $on,$on2, array('ulasanbuku.bukuID' => $id));

        $data['buku']=$model->getRow('buku',array('buku.bukuID' => $id));


        
        echo view('buku/ulasan',$data);

    
}

public function tambah_ulasan($idbuku)
{
    $model=new M_model();
    $chat=$this->request->getPost('chat-message');
    $rating=$this->request->getPost('rating');
    $id=session()->get('id');
    $cek=$model->getRow('ulasanbuku',array('userID' => $id, 'bukuID' => $idbuku));
    
    $data=array(
        'ulasan'=>$chat,
        'rating'=>$rating,
        'userID'=>$id,
        'bukuID'=>$idbuku,
    );
    if(empty($cek)){
    $model->simpan('ulasanbuku',$data);
    }else{
        $where=['ulasanID'=> $cek->ulasanID];
        $model->edit('ulasanbuku',$data,$where);
    }

    $log = array(
        'isi_log' => 'user memberikan ulasan pada buku',
        'log_idUser' => $id,
        
    );

    $model->simpan('log', $log);
    return redirect()->to('buku/ulasan/'.$idbuku);
}


}