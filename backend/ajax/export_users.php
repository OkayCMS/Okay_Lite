<?php

class ExportAjax extends Okay {

    /*����(�������) ��� ����� ��������*/
    private $columns_names = array(
        'name'=>             '���',
        'email'=>            'Email',
        'phone'=>            '�������',
        'address'=>          '�����',
        'group_name'=>       '������',
        'discount'=>         '������',
        'enabled'=>          '�������',
        'created'=>          '����',
        'last_ip'=>          '��������� IP'
        
    );
    
    private $column_delimiter = ';';
    private $users_count = 100;
    private $export_files_dir = 'backend/files/export_users/';
    private $filename = 'users.csv';
    
    public function fetch() {
        if(!$this->managers->access('users')) {
            return false;
        }
        
        // ������ ������ ������ 1251
        setlocale(LC_ALL, 'ru_RU.1251');
        $this->db->query('SET NAMES cp1251');
        
        // ��������, ������� ������������
        $page = $this->request->get('page');
        if(empty($page) || $page==1) {
            $page = 1;
            // ���� ������ ������� - ������ ������ ���� ��������
            if(is_writable($this->export_files_dir.$this->filename)) {
                unlink($this->export_files_dir.$this->filename);
            }
        }
        
        // ��������� ���� �������� �� ����������
        $f = fopen($this->export_files_dir.$this->filename, 'ab');
        
        // ���� ������ ������� - ������� � ������ ������ �������� �������
        if($page == 1) {
            fputcsv($f, $this->columns_names, $this->column_delimiter);
        }
        
        $filter = array();
        $filter['page'] = $page;
        $filter['limit'] = $this->users_count;
        if($this->request->get('group_id')) {
            $filter['group_id'] = intval($this->request->get('group_id'));
        }
        $filter['sort'] = $this->request->get('sort');
        
        // �������� �������������
        $users = array();
        foreach($this->users->get_users($filter) as $u) {
            $str = array();
            foreach($this->columns_names as $n=>$c) {
                $str[] = $u->$n;
            }
            fputcsv($f, $str, $this->column_delimiter);
        }
        
        $total_users = $this->users->count_users($filter);
        
        if($this->users_count*$page < $total_users) {
            return array('end'=>false, 'page'=>$page, 'totalpages'=>$total_users/$this->users_count);
        } else {
            return array('end'=>true, 'page'=>$page, 'totalpages'=>$total_users/$this->users_count);
        }
        
        fclose($f);
    }
    
}

$export_ajax = new ExportAjax();
$data = $export_ajax->fetch();
if ($data) {
    header("Content-type: application/json; charset=utf-8");
    header("Cache-Control: must-revalidate");
    header("Pragma: no-cache");
    header("Expires: -1");
    $json = json_encode($data);
    print $json;
}
