<?php

require_once('api/Okay.php');

class PostAdmin extends Okay {
    
    public function fetch() {
        $post = new stdClass;
        if($this->request->method('post')) {
            $post->id = $this->request->post('id', 'integer');
            $post->name = $this->request->post('name');
            $post->date = date('Y-m-d', strtotime($this->request->post('date')));
            
            $post->visible = $this->request->post('visible', 'boolean');
            
            $post->url = trim($this->request->post('url', 'string'));
            $post->meta_title = $this->request->post('meta_title');
            $post->meta_keywords = $this->request->post('meta_keywords');
            $post->meta_description = $this->request->post('meta_description');
            
            $post->annotation = $this->request->post('annotation');
            $post->text = $this->request->post('body');
            
            // Не допустить одинаковые URL разделов.
            if(($a = $this->blog->get_post($post->url)) && $a->id!=$post->id) {
                $this->design->assign('message_error', 'url_exists');
            } elseif(empty($post->name)) {
                $this->design->assign('message_error', 'empty_name');
            } elseif(empty($post->url)) {
                $this->design->assign('message_error', 'empty_url');
            } elseif(substr($post->url, -1) == '-' || substr($post->url, 0, 1) == '-') {
                $this->design->assign('message_error', 'url_wrong');
            } else {
                if(empty($post->id)) {
                    $post->id = $this->blog->add_post($post);
                    $this->design->assign('message_success', 'added');
                } else {
                    $this->blog->update_post($post->id, $post);
                    $this->design->assign('message_success', 'updated');
                }
                
                // Удаление изображения
                if ($this->request->post('delete_image')) {
                    $this->image->delete_image($post->id, 'image', 'blog', $this->config->original_blog_dir, $this->config->resized_blog_dir);
                }
                // Загрузка изображения
                $image = $this->request->files('image');
                if (!empty($image['name']) && ($filename = $this->image->upload_image($image['tmp_name'], $image['name'], $this->config->original_blog_dir))) {
                    $this->image->delete_image($post->id, 'image', 'blog', $this->config->original_blog_dir, $this->config->resized_blog_dir);
                    $this->blog->update_post($post->id, array('image'=>$filename));
                }
                $post = $this->blog->get_post($post->id);
            }
        } else {
            $post->id = $this->request->get('id', 'integer');
            $post = $this->blog->get_post(intval($post->id));
        }
        
        if(empty($post)) {
            $post = new stdClass;
            $post->date = date($this->settings->date_format, time());
        }
        $this->design->assign('post', $post);
        return $this->design->fetch('post.tpl');
    }
    
}
