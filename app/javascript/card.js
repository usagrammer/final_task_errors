function pay() {
  Payjp.setPublicKey("pk_test_530d79abed1768b5d8674052");
  let form = document.getElementById("charge-form");
  form.addEventListener("submit", () => {
    let formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("number"),
      cvc: formData.get("cvc"),
      exp_month: formData.get("exp_month"),
      exp_year: `20${formData.get("exp_year")}`,
    };
    // cardのなかみ
    // {number: "424242424242", exp_month: "21", exp_year: "2042", cvc: "123"}

    console.log("card情報");
    console.log(card);

    Payjp.createToken(card, function (status, response) {
      if (status === 200) {
        console.log("成功のresponse");
        console.log(response);
      } else {
        console.log("失敗のresponse");
        console.log(response);
      }
    });
  });
}

window.addEventListener("load", pay);

// apitunnel.html:150 POST https://api.pay.jp/v1/tokens 402
// load @ apitunnel.html:150
// i.handleMessage @ apitunnel.html:202
// attachedCallback @ apitunnel.html:61
// card.js:25 失敗のresponse
// card.js:26 {error: {…}}
