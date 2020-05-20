const pay = () => {
  Payjp.setPublicKey("pk_test_530d79abed1768b5d8674052");
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", () => {
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("number"),
      cvc: formData.get("cvc"),
      exp_month: formData.get("exp_month"),
      exp_year: `20${formData.get("exp_year")}`,
    };

    Payjp.createToken(card, (status, response) => {
      if (status === 200) {
        const token = response.id;
        // 描画先の要素を取得
        const renderDom = document.getElementById("<取得先>");
        // 描画するそのものを定義
        const tokenObj = `<input value=${token}>`;
        // 描画する
        renderDom.insertAdjacentHTML("afterend", tokenObj);
      } else {
      }
    });
  });
};

window.addEventListener("load", pay);
