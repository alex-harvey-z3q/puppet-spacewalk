require 'spec_helper'

describe 'spacewalk::server' do
  context 'with defaults' do
    it { is_expected.to compile.with_all_deps }
  end

  context 'manage_repos => true' do
    let(:params) {{
      :manage_repos => true,
    }}
    it { is_expected.to compile.with_all_deps }
  end

  context 'answers file' do
    [
      [:admin_email,         'root@localhost'],
      [:ssl_set_org,         'some org'      ],
      [:ssl_set_org_unit,    'some org unit' ],
      [:ssl_set_city,        'some city'     ],
      [:ssl_set_state,       'some state'    ],
      [:ssl_set_country,     'some country'  ],
      [:ssl_password,        'sslpassword'   ],
      [:ssl_set_email,       'root@localhost'],
      [:ssl_config_sslvhost, 'Y'             ],
      [:db_password,         'dbpassword'    ],
      [:db_port,             '1234'          ],
    ]
    .each do |param, value|
      context param do
        let(:params) {{
          param => value
        }}
        it {
          is_expected.to contain_file('/etc/sysconfig/spacewalk.answers').
            with_content(/#{value}/)
        }
      end
    end
  end
end
