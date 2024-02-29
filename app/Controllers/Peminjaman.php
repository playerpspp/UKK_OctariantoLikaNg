<?php

namespace App\Controllers;

use App\Models\M_model;

class Peminjaman extends BaseController
{
    protected function checkAuth()
    {
        $id_user = session()->get('id');
        $level = session()->get('level');
        if ($id_user != null) {
            return true;
        } else {
            return false;
        }
    }

    public function index()
    {
         if (!$this->checkAuth()) {
            return redirect()->to(base_url('/home/dashboard'));
        }

        $model = new M_model();
        $on="peminjaman.bukuID_peminjaman=buku.bukuID";
        $on2="peminjaman.userID=user.id_user";
        if(session()->get('level') != "peminjam"){
        $data['data']= $model->super('peminjaman','buku','user',$on,$on2);
        }else{
            $data['data']= $model->super_w('peminjaman','buku','user',$on,$on2, ['userID' => session()->get('id')]);
        }
        // $data['kategori']= $model->relasiKategori();
        echo view('peminjaman/peminjaman',$data);
        // print_r($data['kategori']);
    }

    public function input()
    {
         if (!$this->checkAuth()) {
            return redirect()->to(base_url('/home/dashboard'));
        }

        $model = new M_model();
        $on="buku.bukuID=peminjaman.bukuID_peminjaman";
        $data['data']= $model->fusionleft('buku', 'peminjaman',$on);
        $data['peminjam']= $model->getWhere('user',['level' => "peminjam"]);
        // print_r($data);
        echo view('peminjaman/input',$data);
    }

    public function aksi_input()
    {
         if (!$this->checkAuth()) {
            return redirect()->to(base_url('/home/dashboard'));
        }

        // print_r($this->request->getPost('kategori'));

       
        $bukuID=$this->request->getPost('bukuID');
        $userID=$this->request->getPost('peminjam');
        $pengembalian=$this->request->getPost('pengembalian');
        $maker_pegawai=session()->get('id');

        $peminjaman=array(
            'bukuID_peminjaman'=>$bukuID,
            'userID'=>$userID,
            'tanggalPengembalian'=>$pengembalian,
        );

        $model=new M_model();
        $model->simpan('peminjaman', $peminjaman);
        // print_r($buku);

        
        $log = array(
            'isi_log' => 'user menambahkan data peminjaman',
            'log_idUser' => $maker_pegawai,
            
        );

        $model->simpan('log', $log);
        return redirect()->to('/peminjaman');

    }

    public function pengembalian($id)
    {
        if (!$this->checkAuth()) {
            return redirect()->to(base_url('/home/dashboard'));
        }

        $peminjaman=array(
            'statusPeminjaman'=> 2,
        );

        $model=new M_model();
        $model->edit('peminjaman', $peminjaman, ['peminjamanID' => $id]);
      

        
        $log = array(
            'isi_log' => 'user mengubah status peminjaman buku',
            'log_idUser' => session()->get('id'),
            
        );

        $model->simpan('log', $log);
        return redirect()->to('/peminjaman');


    }

    public function hapus($id)
    {
    if (!$this->checkAuth()) {
        return redirect()->to(base_url('/home/dashboard'));
    }

        $model=new M_model();
        $where2=array('peminjamanID'=>$id);

        $model->hapus('peminjaman',$where2);

        $log = array(
            'isi_log' => 'user menghapus data peminjaman',
            'log_idUser' => session()->get('id'),
            
        );

        $model->simpan('log', $log);

        return redirect()->to('/peminjaman');

        
    }


}