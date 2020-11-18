import consumer from "./consumer";

window.addEventListener("DOMContentLoaded", () => {
  const commentForm = document.querySelector("#comment-form");

  if (commentForm) {
    consumer.subscriptions.create(
      {
        // これらがcomments_channel.rbのparamsに送られる
        channel: "CommentsChannel",
        item_id: location.pathname.match(/\d+/)[0],
      },
      {
        connected() {
          // ActionCableと通信を確立した際にコンソールにインフォメーションを出力
          console.info("connected channnel");
        },

        disconnected() {
          // Called when the subscription has been terminated by the server
        },

        received(data) {
          // data =>  {
          //   "comment"=>{"id"=>72, "content"=>"aaaa", "user_id"=>2, "item_id"=>1, "created_at"=>"2020-08-20T07:54:25.909Z", "updated_at"=>"2020-08-20T07:54:25.909Z"},
          //   "user"=>{"id"=>2, "nickname"=>"yamada", "email"=>"yamada@taro", "first_name"=>"山田", "last_name"=>"太郎", "first_name_kana"=>"ヤマダ", "last_name_kana"=>"タ...}
          // }
          console.info("recieved data");
          console.log(data);
          const html = `
          <div class="comment">
            <div class="user-info">${data.user.nickname}</div>
            <p>${data.comment.content}</p>
          </div>
        `;
          const comments = document.getElementById("comments");
          comments.insertAdjacentHTML("beforeend", html);
          comments.scrollTop = comments.scrollHeight;
        },
      }
    );
  }
});
