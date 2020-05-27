window.addEventListener("DOMContentLoaded", () => {
  // 決済処理を許可するurlは</items/:id/transactions>の場合です。
  const path = location.pathname
  const params = path.replace(/items/g, '').replace(/transactions/g, '').replace(/\//g, '');
  if (path.includes("items") && path.includes("transactions") && /^([1-9]\d*|0)$/.test(params)) {
    const PAYJP_PK = process.env.PAYJP_PK
    Payjp.setPublicKey(PAYJP_PK);
    const form = document.getElementById("charge-form");
    form.addEventListener("submit", (e) => {
      e.preventDefault();
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
          const renderDom = document.getElementById("charge-form");
          const tokenObj = `<input value=${token} type="hidden" name='token'>`;
          // サーバーにトークン情報を送信するために、inputタグをhidden状態で追加します。
          renderDom.insertAdjacentHTML("beforeend", tokenObj);
          document.getElementById("charge-form").submit();
        } else {
          window.alert('購入処理に失敗しました。\nお手数ですが最初からやり直してください。');
        }
      });
    });
  }
  event.preventDefault();
});