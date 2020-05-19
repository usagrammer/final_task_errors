function pay() {
  let form = document.getElementById("charge-form");
  form.addEventListener("submit", () => {
    let formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);
    const card = {
      number: formData.get("number"),
      exp_month: formData.get("exp_month"),
      exp_year: formData.get("exp_year"),
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

window.addEventListener("load", pay);
