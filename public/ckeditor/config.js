/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
  // Define changes to default configuration here. For example:
  // config.language = 'fr';
  // config.uiColor = '#AADC6E';
  
  config.toolbar = 'MyToolbar';
  config.toolbarCanCollapse = false;
  config.disableNativeSpellChecker = false;
  config.shiftEnterMode = CKEDITOR.ENTER_P;
  config.startupOutlineBlocks = false;
  config.resize_dir = 'vertical';
  config.fillEmptyBlocks = false;
  config.removePlugins = 'elementspath'; //get rid of that silly path bar
  config.skin = 'kama';
  config.format_tags = 'p;h1;h2;h3;pre';
  //config.indentClasses = ['Indent1', 'Indent2', 'Indent3'];
  //config.justifyClasses = [ 'AlignLeft', 'AlignCenter', 'AlignRight', 'AlignJustify' ];
  config.toolbar_MyToolbar =[
      { name: 'clipboard',   items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
      { name: 'editing',     items : [ 'Find','Replace','-','SelectAll','-' ] },
      { name: 'document',    items : [ 'Source','Maximize' ] },
      { name: 'links',       items : [ ] },
      '/',
      { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
      { name: 'paragraph',   items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-', 'Blockquote','Table','Link','Unlink', '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-'] }
  ];
  // config.toolbar_MyToolbar = [
  // {
  //   name: "Toolbar",
  //   items: [
  //   'Format',
  //   'Bold','Italic','Strike', 'RemoveFormat', '-',
  //   'Cut','Copy','Paste','PasteFromWord','-',
  //   'Table', 'Blockquote', 'NumberedList','BulletedList', 'Link','Unlink', '-',
  //   'Undo','Redo', '-',
  //   'Find', '-', 
  //   'Source']}
  // ];
  // config.toolbar_MyToolbar =
  // [
  //   { name: 'styles', items : [ 'Format' ] },
  //   { name: 'basicstyles', items : [ 'Bold','Italic','Strike','-','RemoveFormat' ] },
  //   { name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteFromWord','-','Undo','Redo' ] },
  //   { name: 'paragraph', items : ['Table', 'Blockquote', 'NumberedList','BulletedList', '-', 'Link','Unlink'] },
  //   { name: 'tools', items : [ 'Find', 'Replace', '-', 'Source' ] }
  // ];
};
