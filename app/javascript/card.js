function pay() {
  let form = document.getElementById("charge-form");

  form.addEventListener("submit", () => {

    var card = {
      number: number.value,
      cvc: cvc.value,
      exp_month: exp_month.value,
      exp_year: exp_year.value,
    };

    Payjp.createToken(card, (s, response) => {
      if (response.error) {
        form.find(".payment-errors").text(response.error.message);
        form.find("button").prop("disabled", false);
      } else {
        document.getElementById("number").removeAttr("name");
        document.getElementById("cvc").removeAttr("name");
        document.getElementById("exp_month").removeAttr("name");
        document.getElementById("exp_year").removeAttr("name");
        let token = response.id;
        console.log(token)
        form.append($('<input type="hidden" name="payjpToken" />').val(token));
        
      }
    });
  });
}

window.addEventListener("load", pay);