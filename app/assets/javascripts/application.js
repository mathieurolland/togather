//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery-fileupload/basic
//= require cloudinary/jquery.cloudinary
//= require attachinary
//= require underscore
//= require gmaps/google
//= require turbolinks
//= require moment
//= require bootstrap-datetimepicker
//= require vis
//= require_tree .

$('#signUpModal').on('shown.bs.modal', function () {
  $('#user_first_name').focus();
});

$('#loginModal').on('shown.bs.modal', function () {
  $('#user_email').focus();
});

$('.suggestion-content').scroll(function() {
    $('#hiding-bar').css({opacity: 0});

    if ($('.suggestion-content').scrollTop() === 0) {
        $('#hiding-bar').css({opacity: 1});
    }
});



var IndexPlaces = React.createClass({
    render: function () {
        return (
            <div className={"page " + this.props.position}>
                <Header text="PageSlider"/>
                <div className="content">
                    <ul  className="table-view">
                        <li className="table-view-cell media"><a href="#page1">Page 1</a></li>
                    </ul>
                </div>
            </div>
        );
    }
});
