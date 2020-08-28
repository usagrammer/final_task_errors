if (document.URL.match( /items\/new/ ) || document.URL.match( /items\/edit/ )) {

  document.addEventListener('DOMContentLoaded', function(){
    const imageList = document.getElementById('image-list');
    const flieuploader = document.getElementsByClassName('click-upload')[0];

    const createImageHTML = (blob,index) => {
      // 画像を表示するためのdiv要素を生成
      const imageElement = document.createElement('div');
      imageElement.setAttribute('class', `pre-images`);
      imageElement.dataset.index = index;
      
      // 表示する画像を生成
      const blobImage = document.createElement('img');
      blobImage.style.display ="block";
      blobImage.width = 100;
      blobImage.height = 100;
      blobImage.setAttribute('src', blob);

      //画像の削除ボタン生成
      const ImageEdit = document.createElement('button');
      ImageEdit.setAttribute('class', `images-edit`)
      ImageEdit.innerText ="編集"

      //画像の削除ボタン生成
      const ImageDelete = document.createElement('button');
      ImageDelete.setAttribute('class', `images-delete`)
      ImageDelete.innerText ="削除"

      // ファイル選択ボタンを生成
      const inputHTML = document.createElement('input');
      inputHTML.setAttribute('class', 'item_images');
      inputHTML.setAttribute('name', 'item[images][]');
      inputHTML.setAttribute('type', 'file');
      inputHTML.dataset.index = parseInt(index)+1;

      //画像編集時に既に画像があったら削除する
      pre_image = document.querySelectorAll(`#image-list [data-index="${index}"]`)[0];
      if(pre_image){
        pre_image.remove();
      }
      
       // 生成したHTMLの要素をブラウザに表示させる
      imageElement.appendChild(blobImage);
      imageElement.appendChild(ImageEdit);
      imageElement.appendChild(ImageDelete);
      imageList.appendChild(imageElement);
      flieuploader.appendChild(inputHTML);

      //JSで生成した画像inputのイベントリスナー
      inputHTML.addEventListener('change', (e) => {
        file = e.target.files[0];
        index = e.target.dataset.index
        //画像編集の時、何も選択されていない場合はinputを削除する
        if(file){
          blob = window.URL.createObjectURL(file);
          createImageHTML(blob,index)
        }
        
        else{
          document.querySelectorAll(`[data-index="${edit_num}"]`)[0].remove();
          let fields = document.getElementsByClassName('item_images');

          if ( fields.length > 1){        
            fields[fields.length-1].remove();
         } 
        }
      })

      //画像の編集
      ImageEdit.addEventListener('click', (e) => {
        e.preventDefault();
        edit_ele = e.target.parentNode;
        edit_num = edit_ele.dataset.index;
        document.querySelectorAll(`[data-index="${edit_num}"]`)[1].click();
      });

      //画像の削除
      ImageDelete.addEventListener('click', (e) => {
        e.preventDefault();
        delete_ele = e.target.parentNode
        delete_num = delete_ele.dataset.index;
        delete_ele.remove();

        if ( document.getElementsByClassName('item_images').length > 1){
          document.querySelectorAll(`[data-index="${delete_num}"]`)[0].remove();
        }
        else{
          document.querySelectorAll(`[data-index="${delete_num}"]`)[0].value = ""; 
        }
      });
    };
    
    //1つ目の画像選択のイベント発火用
    document.getElementById('item_images').addEventListener('change', function(e){
      const file = e.target.files[0];
      const index = e.target.dataset.index

      if(file){
        blob = window.URL.createObjectURL(file);
        createImageHTML(blob,index);
      }
      //画像編集の時、何も選択されていない場合はinputを削除する
      else{
        document.querySelectorAll(`[data-index="${edit_num}"]`)[0].remove();
        let fields = document.getElementsByClassName('item_images');

        if ( fields.length > 1){        
          fields[fields.length-1].remove();
        }
      }
    });

    //クリックしてファイルをアップロードで画像選択
    document.getElementById("image-upload").onclick = function(){
      let fields = document.getElementsByClassName('item_images');

      if(document.getElementsByClassName('pre-images').length < 5){
        fields[fields.length-1].click();
      }  
    }

    //input数のバグ防止
    document.getElementsByClassName("sell-btn")[0].onclick = function(){
      let fields = document.getElementsByClassName('item_images')
      if(fields.length == 6 ){fields[fields.length-1].remove();} 
      debugger 
    }
  });
}