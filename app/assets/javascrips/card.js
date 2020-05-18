(function() {
  let form = document.getElementById("charge-form"),
      number = getElementsByFormName('input[name="number"]'),
      cvc = getElementsByFormName('input[name="cvc"]'),
      exp_month = getElementsByFormName('input[name="exp_month"]'),
      exp_year = getElementsByFormName('input[name="exp_year"]');

    document.getElementById("charge-form").submit(function() {
    form.find("input[type=submit]").prop("disabled", true);

    let card = {
        number:  number.value,
        cvc: cvc.value,
        exp_month: exp_month.value,
        exp_year: exp_year.value
    };
    Payjp.createToken(card, function(s, response) {
      if (response.error) {
        form.find('.payment-errors').text(response.error.message);
        form.find('button').prop('disabled', false);
      }
      else {
        document.getElementById("number").removeAttr("name");
        document.getElementById("cvc").removeAttr("name");
        document.getElementById("exp_month").removeAttr("name");
        document.getElementById("exp_year").removeAttr("name");

        let token = response.id;

        form.append(document.body.appendChild(document.createElement('<input type="hidden" name="token" />').val(token)));
        form.get(0).submit();
      }
    });
  });
})();


