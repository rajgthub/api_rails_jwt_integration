json.data do
    json.user do
        json.call(
            @user,
            :email
        )
    end
    json.jwt_token jwt_token
end