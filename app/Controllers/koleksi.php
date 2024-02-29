<?php

namespace App\Controllers;

use App\Models\M_model;

class Koleksi extends BaseController
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
        $cek= $model->getWhere('koleksipribadi',['userID ' => session()->get('id')]);
        $idbuku= [];
        foreach ($cek as $cok){
            $idbuku[] = $cok->bukuID;
        }
        $data['data']= [];
        $data['kategori']=[];
        if (!empty($cek)) {
            $data['data']= $model->koleksiPribadi($idbuku);
        $data['kategori']= $model->relasiKategori();
        }
        // print_r($data);
        echo view('koleksi/koleksi',$data);
    }


    public function tambahKoleksi($idbuku)
    {
         if (!$this->checkAuth()) {
            return redirect()->to(base_url('/home/dashboard'));
        }

       
       
        $id=session()->get('id');

        $koleksi=array(
            'bukuID'=>$idbuku,
            'userID'=> $id
        );

        $model=new M_model();
        $model->simpan('koleksipribadi', $koleksi);
        
        $log = array(
            'isi_log' => 'user menambahkan Koleksi',
            'log_idUser' => $id,
            
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
        $where2=array('bukuID'=>$id,
                     'userID'=>session()->get('id'));

        $model->hapus('koleksipribadi',$where2);

        $log = array(
            'isi_log' => 'user menghapus Koleksi',
            'log_idUser' => session()->get('id'),
            
        );

        $model->simpan('log', $log);

        return redirect()->to('/koleksi');

        
    }


    public function hapusKoleksi($id)
    {
    if (!$this->checkAuth()) {
        return redirect()->to(base_url('/home/dashboard'));
    }

        $model=new M_model();
        $where2=array('bukuID'=>$id,
                     'userID'=>session()->get('id'));

        $model->hapus('koleksipribadi',$where2);

        $log = array(
            'isi_log' => 'user menghapus Koleksi',
            'log_idUser' => session()->get('id'),
            
        );

        $model->simpan('log', $log);

        return redirect()->to('/buku');

        
    }



}