
    $(function(){
      function buildHTML(message){
        if ( message.image ) {
          let html =
            `<div class="message">
              <div class="upper-message">
                <div class="upper-message__username">
                  ${message.user_name}
                </div>
                <div class="upper-message__date">
                  ${message.created_at}
                </div>
              </div>
              <div class="lower-message">
                <p class="lower-message__content">
                  ${message.content}
                </p>
                <img class="lower-message__image" src="${message.image}">
              </div>
            </div>`
          return html;
        } else {
          let html =
          `<div class="message">
            <div class="upper-message">
              <div class="upper-message__user-name">
                ${message.user_name}
              </div>
              <div class="upper-message__date">
                ${message.created_at}
              </div>
            </div>
            <div class="message">
              <p class="message__content">
                ${message.content}
              </p>
            </div>
          </div>`
          return html;
        };
      }
    
      $('.Form').on('submit', function(e){
        e.preventDefault();
        let formData = new FormData(this);
        let url = $(this).attr('action');
        $.ajax({
          url: url,
          type: "POST",
          data: formData,
          dataType: 'json',
          processData: false,
          contentType: false
        })
        .done(function(data){
          console.log(data)
          let html = buildHTML(data);
          $('.Form__contents__submit').prop('disabled', false);
        })
        .fail(function() {
          alert("メッセージ送信に失敗しました");
        });
      });
    });
