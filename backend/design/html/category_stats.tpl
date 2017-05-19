
{$meta_title=$btr->category_stats_sales scope=parent}


<div class="row">
    <div class="col-lg-7 col-md-7">
        <div class="wrap_heading">
            <div class="box_heading heading_page">
                {$btr->category_stats_sales|escape} {$category->name|escape} {$brand->name|escape}
                <span class="hint-right-middle-t-info-s-med-mobile hint-anim" data-hint="{$btr->general_access|escape}">
                    <img src="design/images/exclamation.png">
                </span>
            </div>
        </div>
    </div>
</div>


<div class="boxed fn_toggle_wrap okay_disabled">
    <div class="row">
        <div class="col-lg-12 col-md-12 ">
            <div class="boxed_sorting">
                <div class="row">
                    <div class="col-xs-12 mb-1">
                        <div class="row">
                            <div class="col-md-11 col-lg-11 col-xl-7 col-sm-12">
                                <div class="date">
                                    <form class="date_filter row" method="get">
                                        <input type="hidden" name="module" value="CategoryStatsAdmin" />
                                        <div class="col-md-5 col-lg-5 pr-0 pl-0">
                                            <div class="input-group">
                                                <span class=" input-group-addon-date">{$btr->general_from|escape}</span>
                                                <input class="fn_from_date form-control" name="date_from" value="{$date_from}" autocomplete="off">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-5 col-lg-5 pr-0 pl-0">
                                            <div class="input-group">
                                                <span class=" input-group-addon-date">{$btr->general_to|escape}</span>
                                                <input class="fn_to_date form-control" name="date_to" value="{$date_to}" autocomplete="off">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-2 pr-0">
                                            <button class="btn btn_blue" type="submit">{$btr->general_apply|escape}</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-lg-4 col-sm-12">
                        <select id="id_categories" name="categories_filter" title="{$btr->general_category_filter|escape}" class="selectpicker form-control" data-live-search="true" data-size="10" onchange="location = this.value;">
                            <option value="{url brand=null category=null}" {if !$category}selected{/if}>{$btr->general_all_categories|escape}</option>
                            {function name=category_select level=0}
                                {foreach $categories as $c}
                                    <option value='{url brand=null category=$c->id}' {if $smarty.get.category == $c->id}selected{/if}>
                                        {section sp $level}-{/section}{$c->name|escape}
                                    </option>
                                    {category_select categories=$c->subcategories level=$level+1}
                                {/foreach}
                            {/function}
                            {category_select categories=$categories}
                        </select>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm 12">
                        <select onchange="location = this.value;" class="selectpicker">
                            <option value="{url brand=null}" {if !$brand}selected{/if}>{$btr->general_all_brands|escape}</option>
                            {foreach $brands as $b}
                                <option value="{url brand=$b->id}" {if $brand->id == $b->id}selected{/if}>{$b->name|escape}</option>
                            {/foreach}
                        </select>
                    </div>

                    <div class="col-md-4 col-lg-4 col-sm-12">
                        <button id="fn_start" type="submit" class="btn btn_small btn_blue float-md-right">
                            {include file='svg_icon.tpl' svgId='magic'}
                            <span>{$btr->general_export|escape}</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <form method="post" class="fn_form_list">
        <input type="hidden" name="session_id" value="{$smarty.session.id}" />
        <div class="okay_list products_list fn_sort_list">
            <div class="okay_list_head">
                <div class="okay_list_heading okay_list_categorystats_categories">{$btr->general_category|escape}</div>
                <div class="okay_list_heading okay_list_categorystats_total">{$btr->general_sales_amount|escape}</div>
                <div class="okay_list_heading okay_list_categorystats_setting">{$btr->general_amount|escape}</div>
            </div>
            <div class="okay_list_body">
                {function name=categories_list_tree level=0}
                    {foreach $categories as $category}
                        {if $categories}
                            <div class="okay_list_body_item">
                                <div class="okay_list_row ">
                                    <div class="okay_list_boding okay_list_categorystats_categories">
                                        {$category->name|escape}
                                        <div class="hidden-md-up mt-q">
                                            <span class="text_dark text_600">
                                                <span class="hidden-xs-down">{$btr->general_sales_amount|escape} </span>
                                                <span class="{if $category->price}text_primary {else}text_dark {/if}">
                                                    {$category->price} {$currency->sign}
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="okay_list_boding okay_list_categorystats_total">
                                        {if $category->price}<span class="text_dark">{$category->price} {$currency->sign}</span>{else}{$category->price} {$currency->sign}{/if}
                                    </div>
                                    <div class="okay_list_boding okay_list_categorystats_setting">
                                        {if $category->amount}<span class="text_dark">{$category->amount} {$settings->units}</span>{else}{$category->amount} {$settings->units}{/if}
                                    </div>
                                </div>
                            </div>
                        {/if}
                        {categories_list_tree categories=$category->subcategories level=$level+1}
                    {/foreach}
                {/function}
                {categories_list_tree categories=$categories_list}
            </div>
        </div>
        <div class="row mt-1">
            <div class="col-lg-12 col-md-12">
                <div class="text_dark text_500 text-xs-right mr-1 mt-h">
                    <div class="h5">{$btr->general_total|escape} {$total_price} {$currency->sign|escape} <span class="text_grey">({$total_amount} {$settings->units|escape})</span></div>
                </div>
            </div>
        </div>
    </form>
    <div class="col-lg-12 col-md-12 col-sm 12 txt_center">
        {include file='pagination.tpl'}
    </div>
</div>
{* On document load *}
<script>
    {if $category}
    var category = {$category->id};
    {/if}
    {if $brand}
    var brand = {$brand->id};
    {/if}
    {if $date_from}
    var date_from = '{$date_from}';
    {/if}
    {if $date_to}
    var date_to = '{$date_to}';
    {/if}
</script>
{literal}
    <script src="design/js/jquery/datepicker/jquery.ui.datepicker-ru.js"></script>
    <script type="text/javascript">
        $(function() {
            $('input[name="date_from"]').datepicker({
                regional:'ru'
            });
            $('input[name="date_to"]').datepicker({
                regional:'ru'
            });
            $('button#fn_start').click(function() {
                do_export();
            });
            function do_export(page) {
                page = typeof(page) != 'undefined' ? page : 1;
                category = typeof(category) != 'undefined' ? category : 0;
                brand = typeof(brand) != 'undefined' ? brand : 0;
                date_from = typeof(date_from) != 'undefined' ? date_from : 0;
                date_to = typeof(date_to) != 'undefined' ? date_to : 0;
                $.ajax({
                    url: "ajax/export_stat.php",
                    data: {
                        page: page,
                        category: category,
                        brand: brand,
                        date_from: date_from,
                        date_to: date_to
                    },
                    dataType: 'json',
                    success: function () {

                        window.location.href = 'files/export/export_stat.csv';
                    },
                    error: function (xhr, status, errorThrown) {
                        alert(errorThrown + '\n' + xhr.responseText + 'asdasd');
                    }

                });

            }
        });
    </script>
{/literal}