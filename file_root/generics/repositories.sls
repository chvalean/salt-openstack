{% if grains['os'] == 'CentOS' %}
yum_plugin_priorities_install:
  pkg:
    - installed
    - name: {{ salt['pillar.get']('packages:yum_plugin_priorities') }}
{% endif %}

{% if pillar['cluster_type'] == 'juno' and grains['os'] == 'CentOS' %}
epel_repo_install:
  pkg:
    - installed
    - sources:
      - epel-release: "{{ salt['pillar.get']('packages:epel_repo') }}"

juno_repo_install:
  pkg:
    - installed
    - sources:
      - rdo-release: "{{ salt['pillar.get']('packages:juno_repo') }}"
{% endif %}

{% if pillar['cluster_type'] == 'icehouse' and grains['os'] == 'CentOS' %}
epel_repo_icehouse_install:
  pkg:
    - installed
    - sources:
      - epel-release: "{{ salt['pillar.get']('packages:epel_repo_icehouse') }}"

icehouse_repo_install:
  pkg:
    - installed
    - sources:
      - rdo-release: "{{ salt['pillar.get']('packages:icehouse_repo') }}"
{% endif %}

{% if pillar['cluster_type'] == 'juno' and grains['os'] == 'Ubuntu' %}
ubuntu_cloud_keyring_install:
  pkg:
    - installed
    - name: {{ salt['pillar.get']('packages:ubuntu-cloud-keyring') }}

cloudarchive_juno:
  file:
    - append
    - name: /etc/apt/sources.list.d/cloudarchive-juno.list
    - text: "deb http://ubuntu-cloud.archive.canonical.com/ubuntu trusty-updates/juno main"
    - unless: cat /etc/apt/sources.list.d/cloudarchive-juno.list | egrep "deb http://ubuntu-cloud.archive.canonical.com/ubuntu trusty-updates/juno main"
    - user: root
    - group: root
    - mode: 644
{% endif %}
