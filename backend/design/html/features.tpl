{* Вкладки *}
{capture name=tabs}
    {if in_array('products', $manager->permissions)}
        <li><a href="index.php?module=ProductsAdmin">Товары</a></li>
    {/if}
    {if in_array('categories', $manager->permissions)}
        <li><a href="index.php?module=CategoriesAdmin">Категории</a></li>
    {/if}
    {if in_array('brands', $manager->permissions)}
        <li><a href="index.php?module=BrandsAdmin">Бренды</a></li>
    {/if}
    <li class="active"><a href="index.php?module=FeaturesAdmin">Свойства</a></li>
    <li class="okay_lite disabled"><a href="javascript:;" title="Доступно в полной версии Okay CMS">Промо-изображения</a></li>
{/capture}

{* Title *}
{$meta_title='Свойства' scope=parent}

<div id="header" style="overflow: visible;">
	<h1>Свойства</h1> 
	<a class="add" href="{url module=FeatureAdmin return=$smarty.server.REQUEST_URI}">Добавить свойство</a>
	<div class="helper_wrap">
		<a class="top_help" id="show_help_search" href="https://www.youtube.com/watch?v=eATslZw5RxI" target="_blank"></a>
		<div class="right helper_block topvisor_help">
			<p>Видеоинструкция по разделу</p>
		</div>
	</div>
</div>

{if $features}
    <div id="main_list" class="features">
        <form id="list_form" method="post">
            <input type="hidden" name="session_id" value="{$smarty.session.id}">
            <div id="list">
                {foreach $features as $feature}
                    <div class="{if $feature->in_filter}in_filter{/if} row">
                        <input type="hidden" name="positions[{$feature->id}]" value="{$feature->position}">

                        <div class="move cell">
                            <div class="move_zone"></div>
                        </div>
                        <div class="checkbox cell">
                            <input type="checkbox" id="{$feature->id}" name="check[]" value="{$feature->id}"/>
                            <label for="{$feature->id}"></label>
                        </div>
                        <div class="cell">
                            <a href="{url module=FeatureAdmin id=$feature->id return=$smarty.server.REQUEST_URI}">{$feature->name|escape}</a>
                        </div>
                        <div class="icons cell">
                            <label title="Передавать в выгрузку Я.Маркет" data-vid="{$feature->id}" class="yandex_icon {if $feature->yandex}active{/if}"></label>
                            <a title="Использовать в фильтре" class="in_filter" href='#'></a>
                            <a title="Удалить" class="delete" href='#'></a>
                        </div>
                        <div class="clear"></div>
                    </div>
                {/foreach}
            </div>

            <div id="action">
                <label id="check_all" class="dash_link">Выбрать все</label>
	
                <span id="select">
                    <select name="action">
                        <option value="set_in_filter">Использовать в фильтре</option>
                        <option value="unset_in_filter">Не использовать в фильтре</option>
                        <option value="to_yandex">В яндекс</option>
                        <option value="from_yandex">Из яндекса</option>
                        <option value="delete">Удалить</option>
                    </select>
                </span>
                <input id="apply_action" class="button_green" type="submit" value="Применить">
            </div>

        </form>

    </div>
{else}
    Нет свойств
{/if}


<div id="right_menu">
    {function name=categories_tree}
        {if $categories}
            <ul class="cats_right{if $level > 1} sub_menu{/if}" >
                {if $categories[0]->parent_id == 0}
                    <li {if !$category->id}class="selected"{/if}>
                        <a href="{url category_id=null}">Все категории</a>
                    </li>
                {/if}
                {foreach $categories as $c}
                    <li {if $category->id == $c->id}class="selected"{/if}>
                        <a href="index.php?module=FeaturesAdmin&category_id={$c->id}">{$c->name}</a>
                        {if $c->subcategories}<span class="slide_menu"></span>{/if}
                    </li>
                    {categories_tree categories=$c->subcategories level=$level+1}
                {/foreach}
            </ul>
        {/if}
    {/function}
    {categories_tree categories=$categories level=1}
</div>



{literal}
<script>
$(function() {
    
    $("label.yandex_icon").click(function() {
		var icon        = $(this);
		var id          = icon.data('vid');
		var state       = icon.hasClass('active')?0:1;
        icon.addClass('loading_icon');
		$.ajax({
			type: 'POST',
			url: 'ajax/update_object.php',
			data: {'object': 'feature', 'id': id, 'values': {'yandex': state}, 'session_id': '{/literal}{$smarty.session.id}{literal}'},
			success: function(data){
				icon.removeClass('loading_icon');
                if(!state) {
				    icon.removeClass('active');
				} else {
				    icon.addClass('active');
				}
			},
			dataType: 'json'
		});	
	});

	// Раскраска строк
	function colorize()
	{
		$("#list div.row:even").addClass('even');
		$("#list div.row:odd").removeClass('even');
	}
	// Раскрасить строки сразу
	colorize();
	
	// Сортировка списка
	$("#list").sortable({
		items:             ".row",
		tolerance:         "pointer",
		handle:            ".move_zone",
		axis: 'y',
		scrollSensitivity: 40,
		opacity:           0.7, 
		forcePlaceholderSize: true,
		
		helper: function(event, ui){		
			if($('input[type="checkbox"][name*="check"]:checked').size()<1) return ui;
			var helper = $('<div/>');
			$('input[type="checkbox"][name*="check"]:checked').each(function(){
				var item = $(this).closest('.row');
				helper.height(helper.height()+item.innerHeight());
				if(item[0]!=ui[0]) {
					helper.append(item.clone());
					$(this).closest('.row').remove();
				}
				else {
					helper.append(ui.clone());
					item.find('input[type="checkbox"][name*="check"]').attr('checked', false);
				}
			});
			return helper;			
		},	
 		start: function(event, ui) {
  			if(ui.helper.children('.row').size()>0)
				$('.ui-sortable-placeholder').height(ui.helper.height());
		},
		beforeStop:function(event, ui){
			if(ui.helper.children('.row').size()>0){
				ui.helper.children('.row').each(function(){
					$(this).insertBefore(ui.item);
				});
				ui.item.remove();
			}
		},
		update:function(event, ui)
		{
			$("#list_form input[name*='check']").attr('checked', false);
			$("#list_form").ajaxSubmit(function() {
				colorize();
			});
		}
	});
	
	// Выделить все
	$("#check_all").click(function() {
		$('#list input[type="checkbox"][name*="check"]').attr('checked', $('#list input[type="checkbox"][name*="check"]:not(:checked)').length>0);
	});	
	
	// Указать "в фильтре"/"не в фильтре"
	$("a.in_filter").click(function() {
		var icon        = $(this);
		var line        = icon.closest(".row");
		var id          = line.find('input[type="checkbox"][name*="check"]').val();
		var state       = line.hasClass('in_filter')?0:1;
		icon.addClass('loading_icon');
		$.ajax({
			type: 'POST',
			url: 'ajax/update_object.php',
			data: {'object': 'feature', 'id': id, 'values': {'in_filter': state}, 'session_id': '{/literal}{$smarty.session.id}{literal}'},
			success: function(data){
				icon.removeClass('loading_icon');
				if(!state)
					line.removeClass('in_filter');
				else
					line.addClass('in_filter');				
			},
			dataType: 'json'
		});	
		return false;	
	});

	// Удалить
	$("a.delete").click(function() {
		$('#list input[type="checkbox"][name*="check"]').attr('checked', false);
		$(this).closest("div.row").find('input[type="checkbox"][name*="check"]').attr('checked', true);
		$(this).closest("form").find('select[name="action"] option[value=delete]').attr('selected', true);
		$(this).closest("form").submit();
	});
	
	// Подтверждение удаления
	$("form").submit(function() {
		if($('#list input[type="checkbox"][name*="check"]:checked').length>0)
			if($('select[name="action"]').val()=='delete' && !confirm('Подтвердите удаление'))
				return false;	
	});

    $('.slide_menu').on('click',function(){
        if($(this).hasClass('open')){
            $(this).removeClass('open');
        }
        else{
            $(this).addClass('open');
        }
        $(this).parent().next().slideToggle(500);
    })
    $('.cats_right li.selected').parents('.cats_right.sub_menu').removeClass('sub_menu');
    $('.cats_right li.selected').parents('.cats_right').prev('li').find('span').addClass('open');
	
});
</script>
{/literal}