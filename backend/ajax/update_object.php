<?php

// Проверка сессии для защиты от xss
if(!$okay->request->check_session()) {
    trigger_error('Session expired', E_USER_WARNING);
    exit();
}

$id = intval($okay->request->post('id'));
$object = $okay->request->post('object');
$values = $okay->request->post('values');

switch ($object) {
    case 'product':
        if($okay->managers->access('products')) {
            $result = $okay->products->update_product($id, $values);
        }
        break;
    case 'variant':
        if($okay->managers->access('products')) {
            $result = $okay->variants->update_variant($id, $values);
        }
        break;
    case 'category':
        if($okay->managers->access('categories')) {
            $result = $okay->categories->update_category($id, $values);
        }
        break;
    case 'brands':
        if($okay->managers->access('brands')) {
            $result = $okay->brands->update_brand($id, $values);
        }
        break;
    case 'feature':
        if($okay->managers->access('features')) {
            $result = $okay->features->update_feature($id, $values);
        }
        break;
    case 'page':
        if($okay->managers->access('pages')) {
            $result = $okay->pages->update_page($id, $values);
        }
        break;
    case 'blog':
        if($okay->managers->access('blog')) {
            $result = $okay->blog->update_post($id, $values);
        }
        break;
    case 'delivery':
        if($okay->managers->access('delivery')) {
            $result = $okay->delivery->update_delivery($id, $values);
        }
        break;
    case 'payment':
        if($okay->managers->access('payment')) {
            $result = $okay->payment->update_payment_method($id, $values);
        }
        break;
    case 'currency':
        if($okay->managers->access('currency')) {
            $result = $okay->money->update_currency($id, $values);
        }
        break;
    case 'comment':
        if($okay->managers->access('comments')) {
            $result = $okay->comments->update_comment($id, $values);
        }
        break;
    case 'user':
        if($okay->managers->access('users')) {
            $result = $okay->users->update_user($id, $values);
        }
        break;
    case 'label':
        if($okay->managers->access('labels')) {
            $result = $okay->orders->update_label($id, $values);
        }
        break;
    case 'language':
        if($okay->managers->access('languages')) {
            $result = $okay->languages->update_language($id, $values);
        }
        break;
    case 'category_yandex':
    	if($okay->managers->access('products')) {
            $category = $okay->categories->get_category($id);
            $q = $okay->db->placehold("select v.id from __categories c"
                ." right join __products_categories pc on c.id=pc.category_id"
                ." right join __variants v on v.product_id=pc.product_id"
                ." where c.id in(?@)", $category->children);
            $okay->db->query($q);
            $vids = $okay->db->results('id');
            if (count($vids) == 0) {
                $result = -1;
                break;
            }
            $q = $okay->db->placehold("update __variants set yandex=? where id in(?@)", (int)$values['to_yandex'], $vids);
            $result = (bool)$okay->db->query($q);
    	}
        break;
    case 'brand_yandex':
    	if($okay->managers->access('products')) {
            $q = $okay->db->placehold("select v.id from __products p"
                ." left join __variants v on v.product_id=p.id"
                ." where p.brand_id in(?@)", array($id));
            $okay->db->query($q);
            $vids = $okay->db->results('id');
            if (count($vids) == 0) {
                $result = -1;
                break;
            }
            $q = $okay->db->placehold("update __variants set yandex=? where id in(?@)", (int)$values['to_yandex'], $vids);
            $result = (bool)$okay->db->query($q);
    	}
        break;
    case 'feedback':
        if($okay->managers->access('feedbacks')) {
            $result = $okay->feedbacks->update_feedback($id, $values);
        }
        break;
    
}

header("Content-type: application/json; charset=UTF-8");
header("Cache-Control: must-revalidate");
header("Pragma: no-cache");
header("Expires: -1");
$json = json_encode($result);
print $json;
