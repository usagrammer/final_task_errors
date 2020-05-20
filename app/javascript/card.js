function pay() {
  let form = document.getElementById("charge-form");
  form.addEventListener("submit", () => {
    let formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);
    const card = {
      number: formData.get("number"),
      exp_month: formData.get("exp_month"),
      exp_year: `20${formData.get("exp_year")}`,
      cvc: formData.get("cvc"),
    };

    Payjp.createToken(card, (response) => {
      if (response.error) {
        form.find(".payment-errors").text(response.error.message);
        form.find("button").prop("disabled", false);
      } else {
        // document.getElementById("number").removeAttr("name");
        // document.getElementById("exp_month").removeAttr("name");
        // document.getElementById("exp_year").removeAttr("name");
        // document.getElementById("cvc").removeAttr("name");
        console.log(response);
        // let token = response.id;
        // form.append($('<input type="hidden" name="payjpToken" />').val(token));
      }
    });
  });
}

// card = {
//   card: {
//     number: params[:number],
//     cvc: params[:cvc],
//     exp_month: params[:exp_month],
//     exp_year: '20' + params[:exp_year]
//   }
// }

// result = Payjp::Token.create(
//   card,
//   {
//     # テスト目的のトークン作成
//     # テスト等の目的でトークンの作成処理をサーバーサイドで完結させたい場合、HTTPヘッダーに X-Payjp-Direct-Token-Generate: true を指定して本APIをリクエストすることで、カード情報を直接指定してトークンを作成することができます。この機能はテストモードでのみ利用可能です。
//     'X-Payjp-Direct-Token-Generate': 'true'
//   }
// )

token = result.id

window.addEventListener("load", pay);
