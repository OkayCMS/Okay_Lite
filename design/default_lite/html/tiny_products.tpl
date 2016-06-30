{* Превью товара *}
<div class="fn-product card">
	<div class="card-block fn-transfer">
		{* Изображение товара *}
		<a class="card-image m-b-1" href="{$lang_link}products/{$product->url}">
            {if $product->image->filename}
                <img class="fn-img" src="{$product->image->filename|resize:219:172}" alt="{$product->name|escape}" title="{$product->name|escape}"/>
            {else}
                <img class="fn-img" src="design/{$settings->theme}/images/no_image.png" width="200" height="180" alt="{$product->name|escape}"/>
            {/if}
		</a>

		{* Название товара *}
		<div class="card-title m-b-1">
			<a data-product="{$product->id}" href="{$lang_link}products/{$product->url}">{$product->name|escape}</a>
		</div>

		<div class="row card-price-block">
			{* Старая цена *}
			<div class="col-xs-6 text-line-through text-red{if !$product->variant->compare_price} hidden-xs-up{/if}">
				<span class="fn-old_price">{$product->variant->compare_price|convert}</span> {$currency->sign|escape}
			</div>

			{* Цена *}
			<div class="{if !$product->variant->compare_price}col-xs-12{else}col-xs-6{/if} h5 font-weight-bold m-b-0">
				<span class="fn-price">{$product->variant->price|convert}</span> {$currency->sign|escape}
			</div>
		</div>
		<form class="fn-variants okaycmslite" action="/{$lang_link}cart">
			{* Варианты товара *}
			<select name="variant" class="fn-variant okaycmslite form-control c-select{if $product->variants|count < 2} hidden-xs-up{/if}">
	            {foreach $product->variants as $v}
	                <option value="{$v->id}" data-price="{$v->price|convert}" data-stock="{$v->stock}"{if $v->compare_price > 0} data-cprice="{$v->compare_price|convert}"{/if}{if $v->sku} data-sku="{$v->sku}"{/if}>{if $v->name}{$v->name}{else}{$product->name|escape}{/if}</option>
	            {/foreach}
	        </select>

            {* Нет на складе *}
            <div class="fn-not_preorder m-b-1 {if $product->variant->stock > 0}hidden-xs-up{/if}">
                <button class="btn btn-danger-outline btn-block disabled" type="button" data-language="{$translate_id['tiny_products_out_of_stock']}">{$lang->tiny_products_out_of_stock}</button>
            </div>

            <div class="input-group">
                {* Кнопка добавления в корзину *}
				<button class="fn-is_stock btn btn-warning btn-block i-add-cart{if $product->variant->stock < 1} hidden-xs-up{/if}" data-language="{$translate_id['tiny_products_add_cart']}" type="submit">{$lang->tiny_products_add_cart}</button>
            </div>
		</form>
    </div>
</div>
<!--OkayCMS Lite-->