{if $feature->id}
    {$meta_title = $feature->name scope=parent}
{else}
    {$meta_title = $btr->feature_new scope=parent}
{/if}

{*Название страницы*}
<div class="row">
    <div class="col-lg-12 col-md-12">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                {if !$feature->id}
                    {$btr->feature_add|escape}
                {else}
                    {$feature->name|escape}
                {/if}
            </div>
        </div>
    </div>
    <div class="col-md-12 col-lg-12 col-sm-12 float-xs-right"></div>
</div>

{*Вывод успешных сообщений*}
{if $message_success}
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="boxed boxed_success">
                <div class="heading_box">
                    {if $message_success=='added'}
                        {$btr->feature_added|escape}
                    {elseif $message_success=='updated'}
                        {$btr->feature_updated|escape}
                    {else}
                        {$message_success|escape}
                    {/if}
                    {if $smarty.get.return}
                        <a class="btn btn_return float-xs-right" href="{$smarty.get.return}">
                            {include file='svg_icon.tpl' svgId='return'}
                            <span>{$btr->general_back|escape}</span>
                        </a>
                    {/if}
                </div>
            </div>
        </div>
    </div>
{/if}

{*Вывод ошибок*}
{if $message_error}
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="boxed boxed_warning">
                <div class="heading_box">
                    {if $message_error=='empty_name'}
                        {$btr->general_enter_title|escape}
                    {elseif $message_error == "duplicate_url"}
                        {$btr->feature_duplicate_url|escape}
                    {elseif $message_error=='auto_name_id_exists'}
                        {$btr->feature_auto_name_id_exists|escape}
                    {elseif $message_error=='auto_value_id_exists'}
                        {$btr->feature_auto_value_id_exists|escape}
                    {elseif $message_error == 'forbidden_name'}
                        {$btr->feature_forbidden_name|escape}:<BR>
                        {implode(", ", $forbidden_names)}
                    {else}
                        {$message_error|escape}
                    {/if}
                </div>
            </div>
        </div>
    </div>
{/if}

{*Главная форма страницы*}
<form method="post" enctype="multipart/form-data" class="fn_fast_button fn_is_translit_alpha">
    <input type=hidden name="session_id" value="{$smarty.session.id}">
    <input type="hidden" name="lang_id" value="{$lang_id}" />

    <div class="row">
        <div class="col-xs-12">
            <div class="boxed match_matchHeight_true">
                {*Название элемента сайта*}
                <div class="row d_flex">
                    <div class="col-lg-10 col-md-9 col-sm-12">
                        <div class="heading_label">
                            {$btr->general_name|escape}
                        </div>
                        <div class="form-group">
                            <input class="form-control" name="name" type="text" value="{$feature->name|escape}"/>
                            <input name="id" type="hidden" value="{$feature->id|escape}"/>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-lg-6 col-md-6">
                                <div class="">
                                    <div class="input-group">
                                        <span class="input-group-addon">URL</span>
                                        <input name="url" class="form-control fn_url {if $feature->id}fn_disabled{/if}" {if $feature->id}readonly=""{/if} type="text" value="{$feature->url|escape}" />
                                        <input type="checkbox" id="block_translit" class="hidden" value="1" {if $feature->id}checked=""{/if}>
                                        <span class="input-group-addon fn_disable_url">
                                            {if $feature->id}
                                                <i class="fa fa-lock"></i>
                                            {else}
                                                <i class="fa fa-lock fa-unlock"></i>
                                            {/if}
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 mt-q">
                                <div class="heading_label boxes_inline">{$btr->feature_url_in_product|escape}</div>
                                <div class="boxes_inline">
                                    <div class="okay_switch clearfix">
                                        <label class="switch switch-default">
                                            <input class="switch-input" name="url_in_product" value='1' type="checkbox" id="visible_checkbox" {if $feature->url_in_product}checked=""{/if}/>
                                            <span class="switch-label"></span>
                                            <span class="switch-handle"></span>
                                        </label>
                                    </div>
                                </div>
                             </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-3 col-sm-12">
                        <div class="activity_of_switch">
                            <div class="activity_of_switch_item"> {* row block *}
                                <div class="okay_switch clearfix">
                                    <label class="switch_label">{$btr->feature_filter|escape}</label>
                                    <label class="switch switch-default">
                                        <input class="switch-input" name="in_filter" value='1' type="checkbox" id="visible_checkbox" {if $feature->in_filter}checked=""{/if}/>
                                        <span class="switch-label"></span>
                                        <span class="switch-handle"></span>
                                    </label>
                                </div>
                            </div>
                            <div class="activity_of_switch_item"> {* row block *}
                                <div class="okay_switch clearfix">
                                    <label class="switch_label">{$btr->feature_xml|escape}</label>
                                    <label class="switch switch-default">
                                        <input class="switch-input" name="yandex" value='1' type="checkbox" id="visible_checkbox" {if $feature->yandex}checked=""{/if}/>
                                        <span class="switch-label"></span>
                                        <span class="switch-handle"></span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    {*Параметры элемента*}
    <div class="row">
        <div class="col-lg-6 col-md-12 pr-0">
            <div class="boxed fn_toggle_wrap min_height_210px">
                <div class="heading_box">
                    {$btr->feature_in_categories|escape}
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
                <div class="toggle_body_wrap on fn_card">
                    <div class="boxed boxed_warning">
                        <div class="">
                           {$btr->feature_message|escape}
                        </div>
                    </div>
                    <select class="selectpicker col-xs-12 px-0" multiple name="feature_categories[]" size="10" data-selected-text-format="count" >
                        {function name=category_select selected_id=$product_category level=0}
                            {foreach $categories as $category}
                                <option value='{$category->id}' {if in_array($category->id, $feature_categories)}selected{/if} category_name='{$category->single_name}'>{section name=sp loop=$level}&nbsp;&nbsp;&nbsp;&nbsp;{/section}{$category->name}</option>
                                {category_select categories=$category->subcategories selected_id=$selected_id  level=$level+1}
                            {/foreach}
                        {/function}
                        {category_select categories=$categories}
                    </select>
                </div>
            </div>
        </div>
        <div class="col-lg-6 col-md-12">
            <div class="boxed match fn_toggle_wrap min_height_210px">
                <div class="heading_box">
                    {$btr->general_metatags|escape}
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="icon-arrow-down"></i></a>
                    </div>
                </div>
                <div class="toggle_body_wrap on fn_card">
                    <div class="heading_label" >{$btr->feature_id|escape}</div>
                    <input name="auto_name_id" class="form-control  mb-1" type="text" value="{$feature->auto_name_id|escape}"/>

                    <div class="heading_label" >{$btr->feature_value_id|escape}</div>
                    <input name="auto_value_id" class="form-control mb-t" type="text" value="{$feature->auto_value_id|escape}"/>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        {*Блок алиасов свойств*}
        <div class="col-lg-12 col-md-12 ">
            <div class="boxed fn_toggle_wrap min_height_210px">
                <div class="heading_box">
                    {$btr->feature_feature_aliases|escape}
                    <span class="hint-right-middle-t-info-s-med-mobile hint-anim" data-hint="{$btr->general_access|escape}">
                        <img src="design/images/exclamation.png">
                    </span>
                    <div class="toggle_arrow_wrap fn_toggle_card text-primary">
                        <a class="btn-minimize" href="javascript:;" ><i class="fa fn_icon_arrow fa-angle-down"></i></a>
                    </div>
                </div>
                <div class="toggle_body_wrap on fn_card fn_sort_list okay_disabled">
                    <div class="boxed boxed_warning">
                        <div class="">
                            {$btr->feature_delete_alias_notice|escape}
                        </div>
                    </div>
                    <div class="okay_list ok_related_list">
                        <div class="okay_list_head">
                            <div class="okay_list_heading okay_list_drag"></div>
                            <div class="okay_list_heading feature_alias_name">{$btr->feature_feature_alias_name}</div>
                            <div class="okay_list_heading feature_alias_variable">{$btr->feature_feature_alias_variable}</div>
                            <div class="okay_list_heading feature_alias_value">{$btr->feature_feature_alias_value}</div>
                            <div class="okay_list_heading okay_list_close"></div>
                        </div>
                    </div>
                    <div class="box_btn_heading mt-1">
                        <button type="button" class="btn btn_small btn-info fn_add_feature_alias">
                            {include file='svg_icon.tpl' svgId='plus'}
                            <span>{$btr->feature_add_feature_alias|escape}</span>
                        </button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12 col-md-12 mb-2">
            <button type="submit" class="btn btn_small btn_blue float-md-right">
                {include file='svg_icon.tpl' svgId='checked'}
                <span>{$btr->general_apply|escape}</span>
            </button>
        </div>
    </div>
</form>

{* On document load *}
{literal}
    <script>
        $(function() {
            $('input[name="name"]').keyup(function() {
                if(!$('#block_translit').is(':checked')) {
                    $('input[name="url"]').val(generate_url());
                }
            });
        });
    </script>
{/literal}
