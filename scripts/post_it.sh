#!/bin/bash

. __variables__.sh
. __sign_it__.sh

readonly method="POST"
readonly authorization_header=$(sign_it "${method}")
printf "> ${method}-ing ${api_url}\n"
curl -si -X ${method} "${api_url}" -H "${authorization_header}" -H "${header_x_amz_date}"
