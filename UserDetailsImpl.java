package com.ong.security;

import com.ong.model.Usuario;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import java.util.Collection;
import java.util.stream.Collectors;

@Getter
@AllArgsConstructor
public class UserDetailsImpl implements UserDetails {

    private Long id;
    private String email;
    private String senhaHash;
    private Collection<? extends GrantedAuthority> authorities;

    public static UserDetailsImpl build(Usuario usuario) {
        Collection<GrantedAuthority> authorities = usuario.getPerfil()
            .getPermissoes()
            .stream()
            .map(p -> new SimpleGrantedAuthority(p.getCodigoPermissao()))
            .collect(Collectors.toList());

        return new UserDetailsImpl(usuario.getId(), usuario.getEmail(), usuario.getSenhaHash(), authorities);
    }

    @Override
    public String getUsername() { return email; }
    @Override
    public String getPassword() { return senhaHash; }
    @Override
    public boolean isAccountNonExpired() { return true; }
    @Override
    public boolean isAccountNonLocked() { return true; }
    @Override
    public boolean isCredentialsNonExpired() { return true; }
    @Override
    public boolean isEnabled() { return true; }
}
